# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Cusdis is an open-source, lightweight (~5kb gzip), privacy-friendly comment system alternative to Disqus. It's designed for small websites and static blogs.

## Development Commands

### Development Server
```bash
# SQLite (default)
npm run dev

# PostgreSQL
npm run dev:pg

# MySQL
npm run dev:mysql
```

### Database Operations
```bash
# Generate Prisma client
npm run db:generate

# Deploy/run migrations
npm run db:deploy

# Push schema changes (development only)
npm run db:push        # SQLite
npm run db:push:pg     # PostgreSQL
npm run db:push:mysql  # MySQL

# Create new migration
npm run db:migrate

# Open Prisma Studio (database GUI)
npm run admin
```

### Widget Development
```bash
# Start widget dev server on http://localhost:3001
npm run widget

# Build all widget components
npm run build:widget
npm run build:sdk
npm run build:iframe
npm run build:count
```

### Production Build
```bash
# Build with migrations (PostgreSQL)
npm run build

# Build without migrations
npm run build:without-migrate

# Start production server
npm start
npm start:with-migrate
```

## Architecture

### Multi-Database Support

Cusdis supports three database types: SQLite, PostgreSQL, and MySQL. The database type is controlled by the `DB_TYPE` environment variable, which determines which Prisma schema to use from `prisma/$DB_TYPE/schema.prisma`.

### Core Components

**Next.js Application** (`pages/`)
- Main web app using Next.js 13 with Pages Router
- Dashboard UI at `/dashboard/*`
- Public pages including landing page and documentation
- API routes in `pages/api/`

**Widget System** (`widget/`)
- Embeddable comment widget built with Svelte
- Supports i18n and dark mode
- Multiple build outputs: main widget, SDK, iframe, and count widget
- Built with Vite

**Service Layer** (`service/`)
- Business logic organized by domain:
  - `comment.service.ts` - Comment CRUD and moderation
  - `project.service.ts` - Project/site management
  - `notification.service.ts` - Email notifications
  - `webhook.service.ts` - Webhook triggers
  - `auth.service.ts` - Authentication helpers
  - `subscription.service.ts` - Payment/subscription handling
  - `usage.service.ts` - Usage tracking

**API Routes** (`pages/api/`)
- `auth/` - NextAuth authentication endpoints
- `project/` - Project management endpoints
- `comment/` - Comment CRUD operations
- `open/` - Public API endpoints for widget integration

### Database Schema

Key models in Prisma schema:
- `User` - Site owners who manage projects
- `Project` - Individual websites/blogs
- `Page` - Individual pages within a project
- `Comment` - User comments (supports nested replies via self-referential `parentId`)
- `Subscription` - Premium subscription data

### Authentication

Uses NextAuth 3.x with configurable providers based on environment variables:
- Local credentials (USERNAME/PASSWORD env vars)
- GitHub OAuth
- GitLab OAuth
- Google OAuth

Configured in `config.server.ts` and `utils.server.ts`.

### Configuration

Server configuration is centralized in `utils.server.ts` via `resolvedConfig` object. Key areas:
- Authentication providers
- Email services (SMTP, SendGrid)
- Analytics (Umami, Minicapture)
- Error tracking (Sentry)
- Subscription/checkout (Lemon Squeezy)

### Error Handling

API routes use `next-connect` with Boom for HTTP errors. The `apiHandler()` utility in `utils.server.ts` provides consistent error responses.

## Development Workflow

1. Set up `.env` file with required variables:
   ```
   DB_URL=file:./db.sqlite
   USERNAME=admin
   PASSWORD=password
   JWT_SECRET=your-secret-here
   ```

2. Database changes should be made to schema files in `prisma/$DB_TYPE/schema.prisma`

3. When developing the widget, edit files in `widget/` and test at http://localhost:3001

4. PRs should target the `dev` branch, not `master`

## Key Technical Details

- The project uses decorators (`experimentalDecorators` enabled in tsconfig)
- Prisma client is instantiated as a singleton in development for performance
- Widget uses PostMessage API for cross-origin communication with parent page
- Supports markdown rendering for comments via markdown-it
- Email notifications use either SMTP or SendGrid based on configuration
