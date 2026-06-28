# GPS Sensor Payments API - Installation & Deployment Guide

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Local Development](#local-development)
3. [MongoDB Atlas Setup](#mongodb-atlas-setup)
4. [API Documentation](#api-documentation)
5. [Testing](#testing)
6. [Deployment](#deployment)
7. [Troubleshooting](#troubleshooting)

---

## Prerequisites

- Python 3.9+
- Git
- MongoDB Atlas account (free tier available)
- Postman or similar tool for API testing

---

## Local Development

### 1. Clone Repository
```bash
git clone https://github.com/surindersinghbaatlivala16-jpg/gps-sensor-payments.git
cd gps-sensor-payments
```

### 2. Run Setup Script
```bash
chmod +x setup.sh
./setup.sh
```

### 3. Configure Environment
```bash
# Edit .env with your MongoDB Atlas credentials
nano .env
```

Required environment variables:
```
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/gps-payments?retryWrites=true&w=majority
SECRET_KEY=your-random-secret-key
JWT_SECRET=your-jwt-secret-key
FLASK_ENV=development
```

### 4. Start Application
```bash
source venv/bin/activate
python app.py
```

Application runs on `http://localhost:5000`

---

## MongoDB Atlas Setup

### Step 1: Create Account
1. Visit [mongodb.com/atlas](https://www.mongodb.com/cloud/atlas)
2. Click "Try Free" and sign up
3. Verify your email

### Step 2: Create Cluster
1. Click "Create a Deployment"
2. Select "FREE" tier
3. Choose region (prefer closest to you)
4. Click "Create Deployment"
5. Wait 3-5 minutes for cluster creation

### Step 3: Setup Security
1. Go to "Database Access"
2. Click "Add New Database User"
3. Choose "Password" authentication
4. Set username and password
5. Click "Add User"

### Step 4: Setup Network Access
1. Go to "Network Access"
2. Click "Add IP Address"
3. Click "Allow access from anywhere" (for development)
4. Click "Confirm"

### Step 5: Get Connection String
1. Click "Databases"
2. Click "Connect" on your cluster
3. Select "Drivers"
4. Copy connection string
5. Replace `<password>` with your database password
6. Add `/gps-payments` before query string for database name

Example:
```
mongodb+srv://user:password@cluster0.abc123.mongodb.net/gps-payments?retryWrites=true&w=majority
```

---

## API Documentation

### Base URL
```
http://localhost:5000/api
```

### Authentication Routes

#### Send OTP
```http
POST /auth/send-otp
Content-Type: application/json

{
  "mobile_number": "+11234567890"
}
```

**Response (200):**
```json
{
  "success": true,
  "message": "OTP sent successfully",
  "mobile_number": "****7890",
  "expires_in": 300
}
```

#### Verify OTP & Register/Login
```http
POST /auth/verify-otp
Content-Type: application/json

{
  "mobile_number": "+11234567890",
  "otp": "123456",
  "name": "John Doe",          // Required for new users
  "email": "john@example.com"  // Required for new users
}
```

**Response (200/201):**
```json
{
  "success": true,
  "message": "Login successful",
  "token": "eyJhbGc...",
  "user_id": "507f1f77bcf86cd799439011",
  "name": "John Doe",
  "balance": 0.0
}
```

#### Verify Token
```http
GET /auth/verify-token
Authorization: Bearer eyJhbGc...
```

**Response (200):**
```json
{
  "success": true,
  "user_id": "507f1f77bcf86cd799439011",
  "name": "John Doe",
  "mobile_number": "****7890"
}
```

---

### User Routes

#### Get Profile
```http
GET /user/profile
Authorization: Bearer eyJhbGc...
```

**Response (200):**
```json
{
  "success": true,
  "user": {
    "user_id": "507f1f77bcf86cd799439011",
    "name": "John Doe",
    "email": "john@example.com",
    "mobile_number": "****7890",
    "balance": 150.50,
    "status": "active",
    "created_at": "2026-06-28T10:30:00",
    "last_login": "2026-06-28T14:15:00"
  }
}
```

#### Update Profile
```http
PUT /user/profile
Authorization: Bearer eyJhbGc...
Content-Type: application/json

{
  "name": "John Smith",
  "email": "john.smith@example.com"
}
```

---

### Location Routes

#### Track Location
```http
POST /location/track
Authorization: Bearer eyJhbGc...
Content-Type: application/json

{
  "latitude": 40.7128,
  "longitude": -74.0060,
  "accuracy": 10.5,
  "altitude": 50.2,
  "speed": 5.5,
  "heading": 90.0,
  "address": "123 Main St, New York"
}
```

**Response (201):**
```json
{
  "success": true,
  "location_id": "507f1f77bcf86cd799439012",
  "message": "Location tracked successfully"
}
```

#### Get Current Location
```http
GET /location/current
Authorization: Bearer eyJhbGc...
```

#### Get Location History
```http
GET /location/history?limit=50&skip=0
Authorization: Bearer eyJhbGc...
```

#### Get Nearby Locations
```http
GET /location/nearby?latitude=40.7128&longitude=-74.0060&radius=5
Authorization: Bearer eyJhbGc...
```

---

### Financial Routes

#### Get Balance
```http
GET /financial/balance
Authorization: Bearer eyJhbGc...
```

**Response (200):**
```json
{
  "success": true,
  "balance": 150.50,
  "currency": "USD"
}
```

#### Create Transaction
```http
POST /financial/transaction
Authorization: Bearer eyJhbGc...
Content-Type: application/json

{
  "amount": 50.00,
  "transaction_type": "credit",
  "description": "Payment for service"
}
```

**Transaction Types:** `credit`, `debit`, `transfer`, `refund`

#### Get Transactions
```http
GET /financial/transactions?limit=50&skip=0&status=completed
Authorization: Bearer eyJhbGc...
```

#### Top-up Balance
```http
POST /financial/top-up
Authorization: Bearer eyJhbGc...
Content-Type: application/json

{
  "amount": 100.00,
  "payment_method": "card"
}
```

#### Get Financial Summary
```http
GET /financial/summary
Authorization: Bearer eyJhbGc...
```

#### Get Analytics
```http
GET /financial/analytics?days=30
Authorization: Bearer eyJhbGc...
```

---

## Testing

### Run All Tests
```bash
pytest tests/ -v
```

### Run Specific Test File
```bash
pytest tests/test_auth.py -v
```

### Run with Coverage
```bash
pytest tests/ --cov=. --cov-report=html
```

---

## Deployment

### Using Docker

#### Build Image
```bash
docker build -t gps-payments .
```

#### Run Container
```bash
docker run -p 5000:5000 \
  -e MONGODB_URI="your-mongodb-uri" \
  -e SECRET_KEY="your-secret-key" \
  -e JWT_SECRET="your-jwt-secret" \
  gps-payments
```

#### Using Docker Compose
```bash
docker-compose up -d
```

### Using Heroku

#### 1. Install Heroku CLI
```bash
curl https://cli.heroku.com/install.sh | sh
```

#### 2. Login
```bash
heroku login
```

#### 3. Create Heroku App
```bash
heroku create gps-sensor-payments
```

#### 4. Set Environment Variables
```bash
heroku config:set MONGODB_URI="your-mongodb-uri"
heroku config:set SECRET_KEY="your-secret-key"
heroku config:set JWT_SECRET="your-jwt-secret"
heroku config:set FLASK_ENV="production"
```

#### 5. Deploy
```bash
git push heroku main
```

#### 6. Check Logs
```bash
heroku logs --tail
```

---

## Troubleshooting

### MongoDB Connection Error
**Error:** `Failed to connect to MongoDB Atlas`

**Solution:**
1. Verify connection string in `.env`
2. Check MongoDB Atlas network access (whitelist your IP)
3. Verify username/password credentials
4. Test connection: `mongosh "your-connection-string"`

### OTP Not Sending
**Issue:** OTP not received on mobile

**Current Status:** OTP is logged to console for development
**Production:** Integrate Twilio or similar SMS service

### Token Expired
**Error:** `Token expired`

**Solution:** Use `/api/auth/refresh-token` to get new token

### CORS Errors
**Issue:** Frontend getting CORS errors

**Solution:** Update `CORS_ORIGINS` in `.env`
```
CORS_ORIGINS=http://localhost:3000,http://localhost:8000,https://your-domain.com
```

---

## Support

For issues and questions:
1. Check logs: `docker logs gps-payments`
2. Test health: `curl http://localhost:5000/health`
3. Open GitHub issue: Create issue with detailed description

---

## Security Checklist

✅ Passwords hashed with bcrypt
✅ JWT token validation
✅ Mobile number encryption
✅ Rate limiting enabled
✅ CORS protection
✅ Input validation & sanitization
✅ SQL injection prevention
✅ XSS protection
✅ HTTPS in production
✅ Environment variables secured

---

## Performance Tips

1. **Database Indexing**: Already configured in `database.py`
2. **Connection Pooling**: Using MongoDB connection manager
3. **Caching**: Implement Redis for session caching
4. **Pagination**: Always use `limit` and `skip` parameters
5. **Monitoring**: Set up Sentry for error tracking

