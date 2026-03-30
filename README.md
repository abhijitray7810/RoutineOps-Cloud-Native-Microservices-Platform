# SNU Routine Generator

A comprehensive web application for automated academic routine generation for university departments. This system intelligently creates optimal class schedules while respecting teacher availability, subject requirements, and departmental constraints.

## 🏗️ Architecture Overview

This is a **full-stack MERN application** with the following architecture:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │   Backend API   │    │   Database      │
│   (Next.js)     │◄──►│   (Express.js)  │◄──►│   (MongoDB)     │
│   Port: 3000    │    │   Port: 4000    │    │   Port: 27017   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Technology Stack

#### Frontend
- **Framework**: Next.js 14.2.5 (React 18.2.0)
- **Language**: TypeScript 5.4.5
- **Styling**: TailwindCSS 3.4.4
- **State Management**: Zustand 4.5.2
- **Data Fetching**: TanStack React Query 5.51.1
- **HTTP Client**: Axios 1.6.7
- **UI Components**: Lucide React, Framer Motion
- **PDF Generation**: jsPDF 2.5.2, html2canvas 1.4.1

#### Backend
- **Runtime**: Node.js (ES Modules)
- **Framework**: Express.js 4.21.2
- **Database**: MongoDB with Mongoose ODM 8.20.1
- **Environment**: dotenv 16.4.5
- **CORS**: cors 2.8.5
- **Logging**: morgan 1.10.1
- **Development**: nodemon 3.1.4, cross-env 7.0.3

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ 
- MongoDB 5.0+
- npm or yarn

### Environment Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd snu-routine-generator
   ```

2. **Backend Environment Variables**
   Create `.env` file in `backend/` directory:
   ```env
   PORT=4000
   MONGODB_URI=mongodb://localhost:27017/snu-routine-generator
   FRONTEND_URL=http://localhost:3000
   CORS_ORIGIN=http://localhost:3000
   NODE_ENV=development
   ```

3. **Frontend Environment Variables**
   Create `.env.local` file in `frontend/` directory:
   ```env
   NEXT_PUBLIC_API_BASE_URL=http://localhost:4000/api
   ```

### Installation & Development

1. **Install Dependencies**
   ```bash
   # Backend
   cd backend
   npm install
   
   # Frontend  
   cd ../frontend
   npm install
   ```

2. **Start Development Servers**
   ```bash
   # Terminal 1 - Backend
   cd backend
   npm run dev
   
   # Terminal 2 - Frontend
   cd frontend  
   npm run dev
   ```

3. **Access the Application**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:4000
   - Health Check: http://localhost:4000/api/health

## 📊 Database Schema

### Core Models

#### Teacher
```javascript
{
  name: String,
  email: String,
  department: String,
  subjects: [ObjectId], // References Subject
  availability: [{
    day: String, // Monday-Sunday
    periodsUnavailable: [Number]
  }]
}
```

#### Subject
```javascript
{
  name: String,
  code: String,
  department: String,
  credits: Number,
  totalPeriodsPerWeek: Number,
  labRequired: Boolean,
  preferredDays: [String]
}
```

#### Section
```javascript
{
  name: String,
  department: String,
  year: Number,
  semester: Number,
  totalStudents: Number,
  subjects: [ObjectId] // References Subject
}
```

#### Routine
```javascript
{
  department: String,
  year: Number,
  semester: Number,
  periodsPerDay: Number,
  sections: [{
    name: String,
    timetable: Object // { Monday: [slot|null], ... }
  }],
  unsatisfied: [Object],
  constraints: Object,
  meta: Object
}
```

## 🔌 API Endpoints

### Base URL: `http://localhost:4000/api`

#### Teachers
- `GET /teachers` - List all teachers
- `POST /teachers` - Create new teacher
- `GET /teachers/:id` - Get teacher by ID
- `PUT /teachers/:id` - Update teacher
- `DELETE /teachers/:id` - Delete teacher

#### Subjects
- `GET /subjects` - List all subjects
- `POST /subjects` - Create new subject
- `GET /subjects/:id` - Get subject by ID
- `PUT /subjects/:id` - Update subject
- `DELETE /subjects/:id` - Delete subject

#### Sections
- `GET /sections` - List all sections
- `POST /sections` - Create new section
- `GET /sections/:id` - Get section by ID
- `PUT /sections/:id` - Update section
- `DELETE /sections/:id` - Delete section

#### Routines
- `GET /routines` - List all routines
- `POST /routines/generate` - Generate new routine
- `GET /routines/:id` - Get routine by ID
- `PUT /routines/:id` - Update routine
- `DELETE /routines/:id` - Delete routine

## 🔄 Deployment

### Production Environment Variables

#### Backend (.env)
```env
PORT=4000
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/snu-routine-prod
FRONTEND_URL=https://your-domain.com
CORS_ORIGIN=https://your-domain.com
NODE_ENV=production
```

#### Frontend (.env.local)
```env
NEXT_PUBLIC_API_BASE_URL=https://api.your-domain.com/api
```

### Docker Deployment

1. **Build Backend Image**
   ```bash
   cd backend
   docker build -t snu-routine-backend .
   ```

2. **Build Frontend Image**
   ```bash
   cd frontend
   docker build -t snu-routine-frontend .
   ```

3. **Run with Docker Compose**
   ```yaml
   version: '3.8'
   services:
     mongodb:
       image: mongo:5.0
       ports:
         - "27017:27017"
       volumes:
         - mongodb_data:/data/db
     
     backend:
       image: snu-routine-backend
       ports:
         - "4000:4000"
       environment:
         - MONGODB_URI=mongodb://mongodb:27017/snu-routine-prod
       depends_on:
         - mongodb
     
     frontend:
       image: snu-routine-frontend
       ports:
         - "3000:3000"
       environment:
         - NEXT_PUBLIC_API_BASE_URL=http://localhost:4000/api
       depends_on:
         - backend
   
   volumes:
     mongodb_data:
   ```

### Cloud Deployment Options

#### Vercel (Frontend)
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy frontend
cd frontend
vercel --prod
```

#### Railway/Render (Backend)
```bash
# Deploy backend with Railway
cd backend
railway login
railway deploy
```

## 🔧 Development Workflow

### Adding New Features

1. **Backend Changes**
   - Add models in `backend/src/models/`
   - Create services in `backend/src/services/`
   - Define routes in `backend/src/routes/`
   - Add controllers in `backend/src/controllers/`

2. **Frontend Changes**
   - Add components in `frontend/components/`
   - Create pages in `frontend/app/`
   - Add hooks in `frontend/hooks/`
   - Update store in `frontend/store/`

### Code Structure

```
snu-routine-generator/
├── backend/
│   ├── src/
│   │   ├── config/          # Database configuration
│   │   ├── controllers/     # Request handlers
│   │   ├── middleware/      # Express middleware
│   │   ├── models/          # Mongoose schemas
│   │   ├── routes/          # API routes
│   │   ├── services/        # Business logic
│   │   ├── utils/           # Helper functions
│   │   ├── app.js           # Express app setup
│   │   └── server.js        # Server entry point
│   ├── package.json
│   └── .env
├── frontend/
│   ├── app/                 # Next.js app router
│   ├── components/          # React components
│   ├── hooks/               # Custom React hooks
│   ├── lib/                 # Utility libraries
│   ├── store/               # State management
│   ├── styles/              # CSS/Tailwind
│   ├── package.json
│   └── .env.local
└── README.md
```

## 🔍 Monitoring & Logging

### Application Logs
- Backend uses Morgan for HTTP request logging
- Database connection logs via Mongoose
- Error handling with custom error middleware

### Health Checks
- `GET /api/health` - Application health status
- Database connectivity verification
- CORS configuration validation

## 🛠️ Troubleshooting

### Common Issues

1. **MongoDB Connection Failed**
   - Verify MongoDB is running on port 27017
   - Check MONGODB_URI in environment variables
   - Ensure network connectivity to MongoDB

2. **CORS Errors**
   - Verify FRONTEND_URL and CORS_ORIGIN in backend .env
   - Check frontend API base URL configuration
   - Ensure ports match between frontend and backend

3. **Build Failures**
   - Clear node_modules and reinstall dependencies
   - Verify Node.js version compatibility (18+)
   - Check TypeScript compilation errors

### Performance Optimization

1. **Database Indexing**
   - Routine schema has compound index on department/year/semester
   - Add indexes for frequently queried fields

2. **Frontend Optimization**
   - React Query caching for API responses
   - Code splitting with Next.js dynamic imports
   - Image optimization with Next.js Image component

## 📝 License

This project is licensed under the MIT License.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📞 Support

For technical support or questions:
- Create an issue in the repository
- Contact the development team
- Check the troubleshooting section above
