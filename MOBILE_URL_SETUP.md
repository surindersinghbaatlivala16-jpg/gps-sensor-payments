"""
MOBILE URL SETUP GUIDE - Works on Any Phone
================================================

Complete step-by-step guide to create a public URL that works on
any mobile device without complicated networking setup.
"""

# ============================================================================
# 🎯 FASTEST WAY: NGROK (5 minutes) - RECOMMENDED
# ============================================================================

"""
WHAT IS NGROK?
- Secure tunnel from your local computer to the internet
- Works on ANY phone, ANY network
- Perfect for testing and demo purposes
- Free tier includes 1 concurrent connection

STEP-BY-STEP:

1. INSTALL NGROK
   - Mac: brew install ngrok
   - Windows: Download from https://ngrok.com/download
   - Linux: Download from https://ngrok.com/download

2. GET YOUR API KEY
   - Sign up at https://ngrok.com (free)
   - Copy your authtoken from https://dashboard.ngrok.com/auth/your-authtoken
   
3. SAVE AUTHTOKEN
   Mac/Linux:
   $ ngrok config add-authtoken YOUR_AUTHTOKEN_HERE
   
   Windows (Command Prompt):
   > ngrok config add-authtoken YOUR_AUTHTOKEN_HERE

4. START YOUR FLASK APP
   In Terminal 1:
   $ python app.py
   
   Output should show:
   * Running on http://127.0.0.1:5000

5. START NGROK TUNNEL
   In Terminal 2:
   $ ngrok http 5000
   
   Output will show:
   Forwarding    https://abc123xyz.ngrok.io -> http://localhost:5000

6. USE IN MOBILE APP
   Replace your base URL with:
   https://abc123xyz.ngrok.io/api
   
   Example:
   - Send OTP: https://abc123xyz.ngrok.io/api/auth/send-otp
   - Track Location: https://abc123xyz.ngrok.io/api/location/track
   - Get Balance: https://abc123xyz.ngrok.io/api/financial/balance

THAT'S IT! ✅
Your API is now accessible from any phone on any network.
"""


# ============================================================================
# 🌐 PRODUCTION URL: HEROKU (15 minutes) - FREE
# ============================================================================

"""
FOR REAL PRODUCTION USE - Deploy to Heroku

STEP-BY-STEP:

1. CREATE HEROKU ACCOUNT
   - Sign up at https://www.heroku.com

2. INSTALL HEROKU CLI
   Mac: brew tap heroku/brew && brew install heroku
   Windows: Download from https://devcenter.heroku.com/articles/heroku-cli
   Linux: Download from https://devcenter.heroku.com/articles/heroku-cli

3. LOGIN TO HEROKU
   $ heroku login
   (Opens browser to authenticate)

4. CREATE PROCFILE
   Create file "Procfile" in project root:
   
   web: gunicorn --bind 0.0.0.0:$PORT app:app

5. INITIALIZE GIT (if not already done)
   $ git init
   $ git add .
   $ git commit -m "Initial commit"

6. CREATE HEROKU APP
   $ heroku create gps-sensor-payments
   
   Your app URL: https://gps-sensor-payments.herokuapp.com

7. SET ENVIRONMENT VARIABLES
   $ heroku config:set MONGODB_URI="your-mongodb-atlas-uri"
   $ heroku config:set SECRET_KEY="your-secret-key"
   $ heroku config:set JWT_SECRET="your-jwt-secret"
   $ heroku config:set FLASK_ENV="production"

8. DEPLOY
   $ git push heroku main
   
   Wait for deployment to complete...

9. CHECK DEPLOYMENT
   $ heroku logs --tail
   
   Should show:
   "Running on https://gps-sensor-payments.herokuapp.com"

10. USE IN MOBILE APP
    API Base URL: https://gps-sensor-payments.herokuapp.com/api

THAT'S IT! Your app is live! 🎉
"""


# ============================================================================
# QUICK COMPARISON TABLE
# ============================================================================

"""
┌────────────────────┬──────────────┬──────────────┬─────────────────┐
│ Method             │ Setup Time   │ Cost         │ Best For        │
├────────────────────┼──────────────┼──────────────┼─────────────────┤
│ NGROK (Tunnel)     │ 5 minutes    │ FREE/Paid    │ Quick testing   │
│ Heroku (Deploy)    │ 15 minutes   │ FREE/Paid    │ Production      │
│ Railway            │ 10 minutes   │ FREE/Paid    │ Production      │
│ Render             │ 10 minutes   │ FREE/Paid    │ Production      │
│ DigitalOcean       │ 20 minutes   │ Paid         │ Full control    │
└────────────────────┴──────────────┴──────────────┴─────────────────┘
"""


# ============================================================================
# 📱 TEST YOUR MOBILE URL - Using cURL or Postman
# ============================================================================

"""
AFTER GETTING YOUR URL (e.g., https://abc123xyz.ngrok.io)

1. TEST WITH CURL
   
   Mac/Linux:
   
   # Send OTP
   curl -X POST https://abc123xyz.ngrok.io/api/auth/send-otp \
     -H "Content-Type: application/json" \
     -d '{"mobile_number": "+11234567890"}'
   
   # Should get response:
   {
     "success": true,
     "message": "OTP sent successfully",
     "mobile_number": "****7890",
     "expires_in": 300
   }

2. TEST IN POSTMAN
   - Open Postman
   - New Request
   - POST https://abc123xyz.ngrok.io/api/auth/send-otp
   - Headers: Content-Type: application/json
   - Body (raw JSON):
     {
       "mobile_number": "+11234567890"
     }
   - Click Send

3. TEST ON PHONE
   - Open Postman app on phone
   - Same steps as desktop
   - OR use mobile app built with Flutter/React Native

4. TEST WITH PYTHON
   
   import requests
   
   url = "https://abc123xyz.ngrok.io/api/auth/send-otp"
   data = {"mobile_number": "+11234567890"}
   response = requests.post(url, json=data)
   print(response.json())
"""


# ============================================================================
# 🔄 CONTINUOUS TESTING - Automated Testing Script
# ============================================================================

TESTING_SCRIPT = """
#!/bin/bash

# Save this as: test_mobile_api.sh
# Usage: ./test_mobile_api.sh https://your-url.ngrok.io

API_URL="$1/api"

if [ -z "$API_URL" ]; then
    echo "Usage: $0 <base_url>"
    echo "Example: $0 https://abc123.ngrok.io"
    exit 1
fi

echo "🧪 Testing GPS Sensor Payments API"
echo "📍 API URL: $API_URL"
echo ""

# Test 1: Send OTP
echo "Test 1️⃣: Send OTP"
OTP_RESPONSE=$(curl -s -X POST "$API_URL/auth/send-otp" \
  -H "Content-Type: application/json" \
  -d '{"mobile_number": "+11234567890"}')
echo "Response: $OTP_RESPONSE"
echo ""

# Extract OTP from response (in production, check console/SMS)
OTP="123456"

# Test 2: Verify OTP
echo "Test 2️⃣: Verify OTP"
LOGIN_RESPONSE=$(curl -s -X POST "$API_URL/auth/verify-otp" \
  -H "Content-Type: application/json" \
  -d "{
    \"mobile_number\": \"+11234567890\",
    \"otp\": \"$OTP\",
    \"name\": \"Test User\",
    \"email\": \"test@example.com\"
  }")
echo "Response: $LOGIN_RESPONSE"

# Extract token from response
TOKEN=$(echo $LOGIN_RESPONSE | grep -o '"token":"[^"]*' | cut -d'"' -f4)
echo "Token: $TOKEN"
echo ""

# Test 3: Get Profile
echo "Test 3️⃣: Get User Profile"
curl -s -X GET "$API_URL/user/profile" \
  -H "Authorization: Bearer $TOKEN" | jq '.'
echo ""

# Test 4: Track Location
echo "Test 4️⃣: Track Location"
curl -s -X POST "$API_URL/location/track" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"latitude\": 40.7128,
    \"longitude\": -74.0060,
    \"accuracy\": 10.5
  }" | jq '.'
echo ""

# Test 5: Get Balance
echo "Test 5️⃣: Get Financial Balance"
curl -s -X GET "$API_URL/financial/balance" \
  -H "Authorization: Bearer $TOKEN" | jq '.'
echo ""

echo "✅ Testing complete!"
"""


# ============================================================================
# 🚀 AUTOMATED SETUP SCRIPT - One Command Setup
# ============================================================================

SETUP_MOBILE_URL_SCRIPT = """
#!/bin/bash

# Save as: setup_mobile_url.sh
# Usage: chmod +x setup_mobile_url.sh && ./setup_mobile_url.sh

echo "🚀 GPS Sensor Payments - Mobile URL Setup"
echo "=========================================="
echo ""

# Check if ngrok is installed
if ! command -v ngrok &> /dev/null; then
    echo "❌ Ngrok not installed"
    echo ""
    echo "Install Ngrok:"
    echo "  Mac: brew install ngrok"
    echo "  Windows: Download from https://ngrok.com/download"
    echo "  Linux: Download from https://ngrok.com/download"
    echo ""
    exit 1
fi

echo "✅ Ngrok installed"
echo ""

# Check if Flask app is running
echo "Checking Flask app..."
if ! curl -s http://localhost:5000/health > /dev/null; then
    echo "❌ Flask app not running on port 5000"
    echo ""
    echo "Start Flask app first:"
    echo "  python app.py"
    echo ""
    exit 1
fi

echo "✅ Flask app is running"
echo ""

# Start ngrok
echo "🔗 Creating ngrok tunnel..."
echo ""

ngrok http 5000 --bind-tls=true

# Note: This will keep running. In another terminal, you'll see the URL.
"""


# ============================================================================
# 📋 CHECKLIST: Before Going Mobile
# ============================================================================

CHECKLIST = """
✅ PRE-DEPLOYMENT CHECKLIST

□ Application starts without errors
□ Database connection works
□ All endpoints respond correctly
□ OTP sending works (check console)
□ Token generation works
□ Location tracking works
□ Financial operations work
□ Error handling is in place
□ Logging is configured
□ Security measures are active
  □ Password hashing
  □ JWT validation
  □ Input sanitization
  □ Rate limiting

✅ DEPLOYMENT CHECKLIST

For NGROK (Testing):
□ Install ngrok
□ Create ngrok account
□ Save authtoken
□ Start Flask app
□ Start ngrok tunnel
□ Get public URL
□ Test endpoints
□ Share URL with team

For HEROKU (Production):
□ Create Heroku account
□ Install Heroku CLI
□ Create Procfile
□ Initialize git repo
□ Create MongoDB Atlas cluster
□ Set environment variables
□ Deploy code
□ Check logs for errors
□ Test all endpoints
□ Setup monitoring

✅ MOBILE APP CHECKLIST

□ Update API base URL
□ Handle OTP verification
□ Store JWT token securely
□ Request location permissions
□ Implement error handling
□ Add loading states
□ Test on multiple devices
□ Test on different networks
□ Handle network errors
□ Implement token refresh
"""


# ============================================================================
# 🔗 FINAL URLS TO USE IN MOBILE APP
# ============================================================================

"""
After following the steps above, your mobile app should use:

FOR LOCAL TESTING:
  http://localhost:5000/api

FOR NGROK TUNNEL (Testing):
  https://abc123xyz.ngrok.io/api
  (URL changes each time you restart ngrok)

FOR HEROKU (Production):
  https://your-app-name.herokuapp.com/api
  (URL stays the same)

FOR RAILWAY (Production):
  https://your-railway-url.railway.app/api

FOR RENDER (Production):
  https://your-render-url.onrender.com/api


EXAMPLE API CALLS FROM MOBILE:

1. Send OTP:
   POST {BASE_URL}/auth/send-otp
   
2. Verify OTP:
   POST {BASE_URL}/auth/verify-otp
   
3. Track Location:
   POST {BASE_URL}/location/track
   Authorization: Bearer {TOKEN}
   
4. Get Balance:
   GET {BASE_URL}/financial/balance
   Authorization: Bearer {TOKEN}
"""


if __name__ == '__main__':
    print(__doc__)
    print("\n" + "="*70)
    print("For detailed instructions, see above!")
    print("="*70)
