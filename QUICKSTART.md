"""Quick start guide for testing the application"""

# GPS Sensor Payments - Quick Start Guide

## 🚀 Get Started in 5 Minutes

### Step 1: Start the Application

#### Option A: Local Development
```bash
# Clone repository
git clone https://github.com/surindersinghbaatlivala16-jpg/gps-sensor-payments.git
cd gps-sensor-payments

# Run setup
chmod +x setup.sh
./setup.sh

# Start app
source venv/bin/activate
python app.py
```

#### Option B: Using Docker
```bash
docker build -t gps-payments .
docker run -p 5000:5000 \
  -e MONGODB_URI="your-mongodb-uri" \
  gps-payments
```

### Step 2: Test with Postman

1. Import `postman-collection.json` into Postman
2. Update `{{base_url}}` variable to `http://localhost:5000`

### Step 3: Quick Test Flow

#### 1. Send OTP
```
POST http://localhost:5000/api/auth/send-otp
{
  "mobile_number": "+11234567890"
}
```
**Copy OTP from console logs**

#### 2. Verify OTP & Login
```
POST http://localhost:5000/api/auth/verify-otp
{
  "mobile_number": "+11234567890",
  "otp": "123456",
  "name": "Test User",
  "email": "test@example.com"
}
```
**Copy token from response and save as `{{auth_token}}`**

#### 3. Track Location
```
POST http://localhost:5000/api/location/track
Authorization: Bearer {{auth_token}}
{
  "latitude": 40.7128,
  "longitude": -74.0060,
  "accuracy": 10.5,
  "address": "New York, NY"
}
```

#### 4. Get Financial Balance
```
GET http://localhost:5000/api/financial/balance
Authorization: Bearer {{auth_token}}
```

#### 5. Create Transaction
```
POST http://localhost:5000/api/financial/transaction
Authorization: Bearer {{auth_token}}
{
  "amount": 50.00,
  "transaction_type": "credit",
  "description": "Test transaction"
}
```

---

## 🔧 MongoDB Atlas Connection

### Get Your Connection String

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Click "Databases" → "Connect"
3. Select "Drivers"
4. Copy connection string
5. Update `.env` file:
```
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/gps-payments?retryWrites=true&w=majority
```

---

## 📱 Mobile App Integration

### API Base URL
```
For Local Development:
http://localhost:5000/api

For Production (after deployment):
https://your-domain.com/api
```

### Sample Mobile Implementation

#### Flutter/Dart
```dart
import 'package:http/http.dart' as http;

final String baseUrl = 'http://localhost:5000/api';

// Send OTP
Future<void> sendOTP(String mobileNumber) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/send-otp'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'mobile_number': mobileNumber}),
  );
  
  if (response.statusCode == 200) {
    print('OTP sent successfully');
  }
}

// Track location
Future<void> trackLocation(String token, double lat, double lon) async {
  final response = await http.post(
    Uri.parse('$baseUrl/location/track'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'latitude': lat,
      'longitude': lon,
      'accuracy': 10.5,
    }),
  );
}
```

#### React Native
```javascript
const API_BASE = 'http://localhost:5000/api';

// Send OTP
const sendOTP = async (mobileNumber) => {
  const response = await fetch(`${API_BASE}/auth/send-otp`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ mobile_number: mobileNumber }),
  });
  return response.json();
};

// Track location
const trackLocation = async (token, latitude, longitude) => {
  const response = await fetch(`${API_BASE}/location/track`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ latitude, longitude, accuracy: 10.5 }),
  });
  return response.json();
};
```

---

## ✅ Testing Checklist

- [ ] Application starts successfully
- [ ] Database connection established
- [ ] Send OTP endpoint working
- [ ] Verify OTP & login working
- [ ] Get user profile working
- [ ] Track location working
- [ ] Get balance working
- [ ] Create transaction working
- [ ] Get transaction history working

---

## 🐛 Troubleshooting

### Database Connection Failed
- Check MongoDB Atlas connection string
- Verify IP whitelist in Network Access
- Test with MongoDB Compass

### OTP Not Showing
- Check application console logs
- OTP displays in console for development
- For SMS, configure Twilio

### API Returning 401
- Verify JWT token is valid
- Check token expiry
- Use refresh-token endpoint

---

## 📚 Next Steps

1. **Deploy to Production**
   - See `INSTALL.md` for Heroku/Docker deployment

2. **Add SMS Integration**
   - Set up Twilio account
   - Update OTP sending in `routes/auth.py`

3. **Create Frontend**
   - Use provided mobile code examples
   - Implement UI for all endpoints

4. **Setup Monitoring**
   - Configure Sentry for error tracking
   - Set up CloudWatch or similar

---

## 📞 Support

- Check `INSTALL.md` for detailed documentation
- Review `README.md` for project overview
- Open GitHub issue for bugs/features

