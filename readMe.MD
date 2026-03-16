# LoyaltyLink – Digital Loyalty App for Small Businesses

## Sprint #2 Project Plan  
**Technology Stack:** Flutter + Firebase

---

# Problem Statement

Small businesses in **Tier-2 and Tier-3 towns** struggle to build customer loyalty because they lack simple and affordable tools to track repeat customers or maintain reward programs.

Most of these businesses rely on **manual methods such as paper punch cards or memory**, which leads to:

- Lost loyalty records
- Poor customer tracking
- No insights about repeat customers
- Difficulty managing reward programs

### Key Question

How might we support small businesses with a **modern digital loyalty experience** that is simple, affordable, and easy to manage?

---

# Solution Overview

We propose **LoyaltyLink**, a mobile application built with **Flutter and Firebase** that enables small businesses to manage digital loyalty programs easily.

The app allows businesses to:

- Track repeat customers
- Assign loyalty points
- Create reward programs
- Monitor customer visits

Customers can:

- Earn loyalty points
- Track reward progress
- Redeem rewards directly through the mobile app

This replaces traditional paper loyalty cards with a **mobile-first experience**.

---

# Target Users

## Primary Users
- Small shop owners
- Cafes
- Grocery stores
- Salons
- Local retailers

## Secondary Users
- Customers who frequently visit these businesses

---

# Technology Stack

| Layer | Technology |
|------|------------|
| Frontend | Flutter |
| Programming Language | Dart |
| Backend | Firebase |
| Database | Cloud Firestore |
| Authentication | Firebase Auth |
| Hosting | Firebase Hosting |
| CI/CD | GitHub Actions |

---

# System Architecture

```
Flutter Mobile App
        │
        ▼
Firebase Authentication
        │
        ▼
Cloud Firestore Database
        │
        ▼
Google Cloud Infrastructure
```

Flutter handles the **user interface**, while Firebase provides **authentication, database, and cloud infrastructure**.

---

# App User Flow

```
User opens app
      │
      ▼
Splash Screen
      │
      ▼
Login / Signup
      │
      ▼
Dashboard
      │
 ┌────┴─────┐
 ▼          ▼
Customers   Rewards
 │          │
 ▼          ▼
Add Points  Redeem Rewards
```

---

# Scope & Boundaries

## In Scope

- Firebase Authentication (Login / Signup)
- Firestore database integration
- Customer profile creation
- Loyalty points tracking
- Reward redemption system
- Flutter UI screens
- Dashboard for businesses

## Out of Scope

- Push notifications
- Payment integration
- Advanced analytics dashboard
- QR scanning system
- Multi-language support

These features may be added in future versions.

---

# MVP (Minimum Viable Product)

The MVP will demonstrate the **core working functionality of the loyalty system**.

## MVP Features

### Authentication
- Sign Up
- Login
- Logout

### Customer Management
- Add customer
- View customer list
- Store customer data in Firestore

### Loyalty Points System
- Add loyalty points
- Track customer points balance

### Rewards System
- Create rewards
- Redeem reward points

### Core Screens

- Splash Screen
- Login / Signup Screen
- Dashboard
- Customers Page
- Rewards Page
- Profile Page

---

# Firestore Database Schema

## Users Collection

```
users
   │
   ├── userId
   │     ├── name
   │     ├── email
   │     ├── phone
   │     └── role (business / customer)
```

## Customers Collection

```
customers
   │
   ├── customerId
   │     ├── name
   │     ├── phone
   │     ├── points
   │     └── visitCount
```

## Rewards Collection

```
rewards
   │
   ├── rewardId
   │     ├── rewardName
   │     ├── pointsRequired
   │     └── description
```

---

# Functional Requirements

The application should:

- Allow users to **register and login using Firebase Authentication**
- Store customer data in **Cloud Firestore**
- Track loyalty points for customers
- Allow businesses to assign and update points
- Allow customers to redeem rewards
- Automatically update UI when database changes

---

# Non-Functional Requirements

### Performance
UI transitions should be under **200 milliseconds**

### Scalability
System should support **100+ users simultaneously**

### Security
- Firebase Authentication tokens
- Firestore security rules

### Responsiveness
Adaptive UI across different Android screen sizes

---

# Roles & Responsibilities

| Role | Team Member | Responsibilities |
|-----|-----|-----|
| UI Lead | Member 1 | Flutter UI screens and wireframes |
| Firebase Lead | Member 2 | Firebase Auth and Firestore setup |
| Backend Logic | Member 3 | Loyalty logic and CRUD operations |
| Testing & Deployment | Member 4 | Testing, CI/CD, APK builds |

---

# Sprint Timeline (4 Weeks)

## Week 1 – Setup & Design
- Finalize app concept
- Create UI wireframes
- Setup Flutter project
- Setup Firebase project
- Configure Firestore database

---

## Week 2 – Core Development
- Implement login and signup
- Build dashboard UI
- Add customer profile screen
- Implement Firestore read/write operations

---

## Week 3 – Integration & Testing
- Connect UI with Firestore
- Implement reward redemption
- Add form validation
- Test CRUD operations

---

## Week 4 – MVP Completion

- UI polish
- Bug fixes
- Application testing
- APK generation
- Documentation and demo preparation

---

# Testing Strategy

### Automated Testing
Flutter widget testing framework.

### Manual Testing

- Login flow
- Customer data entry
- Loyalty points tracking
- Reward redemption

### Device Testing

Testing across multiple Android devices.

---

# Deployment Plan

- Code repository hosted on **GitHub**
- **GitHub Actions** used for CI/CD
- APK build generated for testing
- Optional web deployment using **Firebase Hosting**

---

# Success Metrics

The sprint will be successful if:

- All **MVP features are implemented**
- Firebase **Auth + Firestore integration works**
- Application builds successfully as an **APK**
- Demo works without major bugs
- Mentor review feedback is positive

---

# Risks & Mitigation

| Risk | Impact | Mitigation |
|-----|------|------|
| Firebase configuration issues | Backend delays | Use mock data until Firebase setup works |
| UI bugs | App instability | Modular UI testing |
| Database schema mistakes | Data errors | Plan Firestore structure before development |

---

# Future Improvements

Features planned beyond MVP:

- Push notifications
- QR code scanning for visits
- Business analytics dashboard
- Multi-language support
- Payment integration
- Referral rewards system

---

# Final Vision

LoyaltyLink aims to **empower small businesses with simple digital tools** to build stronger relationships with their customers.

By replacing traditional loyalty cards with a **mobile-first solution powered by Flutter and Firebase**, businesses can increase customer retention while providing a seamless digital experience.