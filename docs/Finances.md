# BeYou - Financial Plan

> **Document Type:** Financial Planning  
> **Version:** 2.1  
> **Last Updated:** January 27, 2026  
> **Team:** 4 Members  
> **Market:** India Only

---

## Project Context

This is a **4-person team project** targeting the Indian wellness market:
- Flutter Developer + Product Lead (You)
- UI/UX Designer
- Backend Developer
- Tester + Security

The financial plan focuses on **minimal viable costs** using free tiers, open-source content, and affordable services.

---

# Revenue Model

## Revenue Streams

```
+====================================================================================+
|                             REVENUE DISTRIBUTION                                   |
+====================================================================================+
|                                                                                    |
|  +--------------------------------------------------------------------------+      |
|  |  1. USER SUBSCRIPTIONS (Primary - 70% of revenue)                        |      |
|  |     Free --> Basic --> Pro                                               |      |
|  |     Rs.0     Rs.49     Rs.99                                             |      |
|  +--------------------------------------------------------------------------+      |
|                                                                                    |
|  +--------------------------------------------------------------------------+      |
|  |  2. CREATOR COMMISSIONS (15% of revenue)                                 |      |
|  |     BeYou takes 15% when user subscribes to creator                      |      |
|  +--------------------------------------------------------------------------+      |
|                                                                                    |
|  +--------------------------------------------------------------------------+      |
|  |  3. STORE COMMISSIONS (10% of revenue)                                   |      |
|  |     10-15% commission on product sales                                   |      |
|  +--------------------------------------------------------------------------+      |
|                                                                                    |
|  +--------------------------------------------------------------------------+      |
|  |  4. ADS (5% of revenue)                                                  |      |
|  |     Google AdMob for free tier users                                     |      |
|  +--------------------------------------------------------------------------+      |
|                                                                                    |
+====================================================================================+
```

| Stream | Revenue Share | Details |
|--------|--------------|--------|
| **1. User Subscriptions** | 70% | Free -> Basic (Rs.49) -> Pro (Rs.99) |
| **2. Creator Commissions** | 15% | BeYou takes 15% when user subscribes to creator |
| **3. Store Commissions** | 10% | 10-15% commission on product sales |
| **4. Ads** | 5% | Google AdMob for free tier users |

---

# Pricing Strategy

## User Subscription Tiers

### Affordable Pricing (India-focused)

| Tier | Monthly | Quarterly | Yearly | Yearly Savings |
|------|---------|-----------|--------|----------------|
| **Free** | Rs.0 | Rs.0 | Rs.0 | - |
| **Basic** | Rs.49 | Rs.129 (Rs.43/mo) | Rs.399 (Rs.33/mo) | 32% |
| **Pro** | Rs.99 | Rs.249 (Rs.83/mo) | Rs.799 (Rs.67/mo) | 32% |

*Pricing comparable to Netflix Mobile (Rs.149), Spotify (Rs.59), YouTube Premium (Rs.129)*

### Feature Comparison

```
+===================================================================================+
|                           FEATURE COMPARISON BY TIER                              |
+===================================================================================+
|                                                                                   |
|  FEATURE                           |  FREE  |  BASIC (Rs.49) |  PRO (Rs.99)       |
|  ----------------------------------+--------+----------------+--------------------+
|  Basic workouts (50)               |   Y    |      Y         |       Y            |
|  Basic meditations (10)            |   Y    |      Y         |       Y            |
|  Food logging (manual)             |   Y    |      Y         |       Y            |
|  Community feed (view)             |   Y    |      Y         |       Y            |
|  Ads                               |  YES   |      NO        |       NO           |
|  ----------------------------------+--------+----------------+--------------------+
|  All workout programs              |   -    |      Y         |       Y            |
|  All meditation content            |   -    |      Y         |       Y            |
|  Recipe library                    |   -    |      Y         |       Y            |
|  Ayurveda & remedies               |   -    |      Y         |       Y            |
|  Wearable sync                     |   -    |      Y         |       Y            |
|  Post to community                 |   -    |      Y         |       Y            |
|  ----------------------------------+--------+----------------+--------------------+
|  Barcode scanner                   |   -    |      -         |       Y            |
|  AI features                       |   -    |      -         |       Y            |
|  "I am Clean" full                 |   -    |      -         |       Y            |
|  Advanced analytics                |   -    |      -         |       Y            |
|  Offline downloads                 |   -    |      -         |       Y            |
|                                                                                   |
+===================================================================================+
```

---

## Creator Commission Structure

| Revenue Type | BeYou Commission | Creator Receives |
|--------------|------------------|------------------|
| Subscriptions | 15% | 85% |
| Program sales | 15% | 85% |
| Consultations | 10% | 90% |
| Tips | 5% | 95% |

---

## Special Offers

### Launch Offers

| Offer | Details |
|-------|---------|
| Lifetime Early Bird | Rs.999 one-time (first 1000 users) |
| First 3 Months | Rs.29/month for Pro |
| Student Discount | 50% off with .edu email |
| Referral | 1 month free for both |

---

# Development Costs (Solo Developer)

## Minimal Viable Costs

### Free/Cheap Services Strategy

```
+====================================================================================+
|                         COST OPTIMIZATION STRATEGY                                 |
+====================================================================================+
|                                                                                    |
|  SERVICE              |  PAID OPTION         |  FREE/CHEAP ALTERNATIVE            |
|  ---------------------+----------------------+------------------------------------+
|  Backend/Auth         |  Firebase Paid       |  Firebase Spark (Free)             |
|  Database             |  Cloud SQL           |  Firestore Free Tier               |
|  Storage              |  Cloud Storage       |  Firebase Storage Free             |
|  Functions            |  Cloud Functions     |  Firebase Functions Free           |
|  Video Hosting        |  Mux ($500/mo)       |  YouTube/Vimeo (Free)              |
|  Search               |  Algolia ($50/mo)    |  Firestore queries                 |
|  Push Notifications   |  OneSignal Paid      |  FCM (Free)                        |
|  Email                |  SendGrid Paid       |  SendGrid Free (100/day)           |
|  Analytics            |  Mixpanel ($25/mo)   |  Firebase Analytics (Free)         |
|  Error Tracking       |  Sentry Paid         |  Crashlytics (Free)                |
|  CI/CD                |  Codemagic Paid      |  GitHub Actions (Free)             |
|  Hosting              |  Vercel Pro          |  Vercel Hobby (Free)               |
|  Domain               |  -                   |  Rs.500-1000/year                  |
|  SSL                  |  Paid                |  Let's Encrypt (Free)              |
|                                                                                    |
+====================================================================================+
```

### Year 1 Spending (Minimal)

| Category | Monthly | Yearly | Notes |
|----------|---------|--------|-------|
| **Firebase Blaze** | Rs.0-500 | Rs.0-6,000 | Pay-as-you-go, mostly free |
| **Domain** | - | Rs.800 | .com or .in domain |
| **Apple Developer** | - | Rs.8,000 | Required for iOS |
| **Google Play** | - | Rs.2,000 | One-time fee |
| **Video Hosting** | Rs.0 | Rs.0 | YouTube unlisted initially |
| **Design Tools** | Rs.0 | Rs.0 | Figma free tier |
| **Icons/Assets** | - | Rs.2,000 | One-time purchase |
| **Food API** | Rs.0-1,000 | Rs.0-12,000 | Open Food Facts (free) |
| **Miscellaneous** | Rs.500 | Rs.6,000 | Unexpected costs |
| **TOTAL** | **~Rs.2,000** | **~Rs.37,000** | |

### One-Time Costs

| Item | Cost | Notes |
|------|------|-------|
| MacBook (if needed) | Rs.80,000-1,50,000 | Required for iOS development |
| iPhone (testing) | Rs.50,000-80,000 | Can use simulator initially |
| Android phone | Rs.15,000-25,000 | For testing |
| **Total Hardware** | **Rs.0-2,55,000** | If you already have devices: Rs.0 |

---

## Firebase Free Tier Limits

| Service | Free Limit | Enough For |
|---------|------------|------------|
| Firestore | 50K reads, 20K writes/day | ~10,000 users |
| Storage | 5 GB | Initial content |
| Authentication | 10K/month | 10,000 signups |
| Cloud Functions | 2M invocations/month | Good for MVP |
| Hosting | 10 GB/month | Web app |
| FCM | Unlimited | All push notifications |

**You can run the app FREE until ~5,000-10,000 active users!**

---

## Cost Scaling Projection

```
+====================================================================================+
|                          COST SCALING BY USER COUNT                                |
+====================================================================================+
|                                                                                    |
|  USERS            |  MONTHLY COST     |  NOTES                                     |
|  -----------------+-------------------+--------------------------------------------+
|  0 - 1,000        |  Rs.0-500         |  Free tier covers                          |
|  1,000 - 5,000    |  Rs.500-2,000     |  Minimal overage                           |
|  5,000 - 10,000   |  Rs.2,000-5,000   |  Start paying                              |
|  10,000 - 25,000  |  Rs.5,000-15,000  |  Upgrade services                          |
|  25,000 - 50,000  |  Rs.15,000-40,000 |  Need better infra                         |
|  50,000+          |  Rs.50,000+       |  Invest in scaling                         |
|                                                                                    |
+====================================================================================+
```

---

# Revenue Projections (Realistic for Solo Dev)

## User Growth (Conservative)

| Month | Total Users | Paid Users | Conversion |
|-------|-------------|------------|------------|
| Month 3 | 500 | 25 | 5% |
| Month 6 | 2,000 | 200 | 10% |
| Month 9 | 5,000 | 625 | 12.5% |
| Month 12 | 10,000 | 1,500 | 15% |

## Monthly Revenue Projection

### Year 1 (Building Phase)

| Month | Users | Paid | Avg Revenue/User | Monthly Revenue |
|-------|-------|------|------------------|-----------------|
| Month 3 | 500 | 25 | Rs.65 | Rs.1,625 |
| Month 6 | 2,000 | 200 | Rs.70 | Rs.14,000 |
| Month 9 | 5,000 | 625 | Rs.75 | Rs.46,875 |
| Month 12 | 10,000 | 1,500 | Rs.80 | Rs.1,20,000 |

*Average revenue = mix of Basic (Rs.49) and Pro (Rs.99) subscribers*

### Year 1 Summary

```
+====================================================================================+
|                          YEAR 1 FINANCIAL SUMMARY                                  |
+====================================================================================+
|                                                                                    |
|  REVENUE                                                                           |
|  -------------------------------------------------------------------------         |
|  Subscriptions                                              Rs.3,00,000            |
|  Creator Commissions                                          Rs.15,000            |
|  Ads (Free users)                                             Rs.10,000            |
|  -------------------------------------------------------------------------         |
|  TOTAL REVENUE                                              Rs.3,25,000            |
|                                                                                    |
|  COSTS                                                                             |
|  -------------------------------------------------------------------------         |
|  Infrastructure                                               Rs.37,000            |
|  -------------------------------------------------------------------------         |
|  TOTAL COSTS                                                 Rs.37,000             |
|                                                                                    |
|  =========================================================================         |
|  NET PROFIT (Year 1)                                        Rs.2,88,000            |
|  =========================================================================         |
|                                                                                    |
|  Note: This assumes your time is free (learning investment)                        |
|                                                                                    |
+====================================================================================+
```

---

## 3-Year Projection

| Year | Users | Paid Users | Annual Revenue | Costs | Profit |
|------|-------|------------|----------------|-------|--------|
| Year 1 | 10,000 | 1,500 | Rs.3,25,000 | Rs.37,000 | Rs.2,88,000 |
| Year 2 | 50,000 | 10,000 | Rs.20,00,000 | Rs.3,00,000 | Rs.17,00,000 |
| Year 3 | 2,00,000 | 40,000 | Rs.80,00,000 | Rs.15,00,000 | Rs.65,00,000 |

---

## Break-Even Analysis

```
+====================================================================================+
|                          BREAK-EVEN ANALYSIS                                       |
+====================================================================================+
|                                                                                    |
|  Monthly Fixed Costs (after launch): Rs.2,000                                      |
|                                                                                    |
|  Average Revenue Per Paid User:                                                    |
|  -------------------------------------------------------------------------         |
|  ARPU = (60% x Rs.49) + (40% x Rs.99) = Rs.69                                      |
|                                                                                    |
|  Break-Even Paid Users:                                                            |
|  -------------------------------------------------------------------------         |
|  = Rs.2,000 / Rs.69 = ~30 paid users                                               |
|  At 10% conversion = 300 total users                                               |
|                                                                                    |
|  =========================================================================         |
|  BREAK-EVEN: ~300 users (achievable in Month 2-3)                                  |
|  =========================================================================         |
|                                                                                    |
+====================================================================================+
```

---

# Funding Strategy (Self-Funded)

## Bootstrap Approach

```
+====================================================================================+
|                             BOOTSTRAP APPROACH                                     |
+====================================================================================+
|                                                                                    |
|  +----------------+     +------------------+     +------------------+              |
|  |   PHASE 1      |     |   PHASE 2        |     |   PHASE 3        |              |
|  |   Development  |---->|   MVP Launch     |---->|   Growth         |              |
|  |   Rs.0 cost    |     |   Rs.10K-15K     |     |   Revenue-funded |              |
|  +----------------+     +------------------+     +------------------+              |
|                                                                                    |
+====================================================================================+
```

#### Phase 1: Development (Rs.0 cost)
- Use free tiers for everything
- Learn and build simultaneously
- No paid services until launch

#### Phase 2: MVP Launch (Rs.10,000-15,000)

| Item | Cost |
|------|------|
| Apple Developer Account | Rs.8,000 |
| Google Play (one-time) | Rs.2,000 |
| Domain | Rs.800 |
| Initial marketing | Rs.3,000 |

#### Phase 3: Growth (Revenue-funded)
- Reinvest 50% of revenue into growth
- Upgrade infrastructure as needed
- Hire help when profitable

> **TOTAL INVESTMENT NEEDED: Rs.15,000-20,000**

---

## Optional: External Funding Later

If the app gains traction, you can consider:

| Stage | When | Amount | Use |
|-------|------|--------|-----|
| Friends & Family | 10K+ users | Rs.2-5 Lakh | Marketing, content |
| Angel | 50K+ users | Rs.10-25 Lakh | Team, scale |
| VC Seed | 1L+ users | Rs.50L-2Cr | Aggressive growth |

---

# Key Metrics to Track

## Monthly Metrics

| Metric | Target (Month 12) |
|--------|-------------------|
| Total Users | 10,000 |
| Monthly Active Users | 5,000 |
| Paid Subscribers | 1,500 |
| Conversion Rate | 15% |
| Monthly Revenue | Rs.1,20,000 |
| Churn Rate | <10% |
| App Rating | 4.5+ stars |

## Unit Economics

| Metric | Target |
|--------|--------|
| CAC (organic) | Rs.0-10 |
| CAC (paid) | Rs.50-100 |
| LTV | Rs.500-1000 |
| ARPU | Rs.70 |
| Gross Margin | 90%+ |

---

# Risk Mitigation

## Financial Risks

| Risk | Mitigation |
|------|------------|
| No users | Focus on SEO, free content, social media |
| Low conversion | Improve onboarding, add value to paid |
| Firebase costs spike | Set billing alerts, optimize queries |
| Competition | Focus on niche (India, Ayurveda) |
| Burnout | Set realistic timeline, take breaks |

## Cost Control Rules

1. **Never exceed Rs.5,000/month** until revenue covers it
2. **Set Firebase billing alerts** at Rs.1,000, Rs.2,000, Rs.5,000
3. **Use free alternatives** until absolutely necessary
4. **Reinvest only 50%** of profit initially

---

# Summary

```
+====================================================================================+
|                          FINANCIAL SUMMARY                                         |
+====================================================================================+
|                                                                                    |
|  INVESTMENT REQUIRED                                                               |
|  -------------------------------------------------------------------------         |
|  Development Phase                                     Rs.0 (your time)            |
|  Launch                                                Rs.15,000-20,000            |
|  First Year Operations                                 Rs.37,000                   |
|  -------------------------------------------------------------------------         |
|  TOTAL                                                 Rs.52,000-57,000            |
|                                                                                    |
|  POTENTIAL RETURNS (Year 1)                                                        |
|  -------------------------------------------------------------------------         |
|  Revenue                                               Rs.3,25,000                 |
|  Profit                                                Rs.2,88,000                 |
|  ROI                                                   500%+                       |
|                                                                                    |
|  =========================================================================         |
|                                                                                    |
|  PRICING: Free, Rs.49/month (Basic), Rs.99/month (Pro)                             |
|                                                                                    |
|  BREAK-EVEN: ~300 users (Month 2-3)                                                |
|                                                                                    |
+====================================================================================+
```

---

*End of Financial Plan*
