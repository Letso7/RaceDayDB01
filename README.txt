# RaceDay1 Event Registration Platform (`RaceDay1.Api`)

## Table of Contents
1. [Project Overview](#project-overview)
2. [Technical Stack & Architecture](#technical-stack--architecture)
3. [Database Design & Entity-Relationship Model (ERD)](#database-design--entity-relationship-model-ERD)
4. [Database Normalization (1NF to 3NF)](#database-normalization-1nf-to-3nf)
5. [Visual Studio Development & Implementation](#visual-studio-development--implementation)
6. [API Endpoints & Controller Implementation](#api-endpoints--controller-implementation)
7. [Setup and Installation Instructions](#setup-and-installation-instructions)
8. [Version Control & GitHub Commit Strategy](#version-control--.github-commit-strategy)
9. [Video Presentation Overview](#video-presentation-overview)
10. [References & Citations](#references--citations).

---

## 1. Project Overview
The **RaceDay1** system is a robust, enterprise-grade backend solution engineered to manage athletic event registrations, participant enrolments, venue tracking, and race results processing. Developed as part of an advanced software engineering and database systems curriculum, this project demonstrates mastery over modern architectural patterns, relational database administration using SQL Server Management Studio (SSMS), RESTful API development in ASP.NET Core, and structured version control workflows.

---

## 2. Technical Stack & Architecture
* **Backend Framework:** ASP.NET Core Web API (.NET)
* **Object-Relational Mapper (ORM):** Entity Framework Core (EF Core) for data mapping, LINQ queries, and database context management.
* **Database Management System:** Microsoft SQL Server / SQL Server Management Studio (SSMS).
* **Data Modeling & UML:** UML Class Diagrams and Entity-Relationship Modeling.
* **Integrated Development Environment:** Visual Studio Enterprise / Community.
* **Version Control:** Git & GitHub (Structured across 20+ atomic commits).

---

## 3. Database Design & Entity-Relationship Model (ERD)
The relational database schema, designated as `RaceDayDB1`, was meticulously architected to ensure complete data integrity, relational consistency, and optimization for multi-table queries.

### Core Tables & Schema Definitions
* **`Users` Table:** Stores administrator, organizer, and participant credentials, roles, and profile information.
* **`Venues` Table:** Captures location specifics, maximum capacity limits, and facility details for scheduled race events.
* **`Race Categories` Table:** Defines divisions based on age groups, distance classifications (e.g., 5km Fun Run, 10km Challenge, 21km Half-Marathon, 42km Marathon), and entry criteria.
* **`Enrolments` Table:** Acts as an associative junction entity linking registered participants to specific race categories and events, recording registration timestamps, payment status, and bib numbers.
* **`Race Results` Table:** Records official completion times, chip timings, final category rankings, and performance metrics for participants upon event conclusion.

