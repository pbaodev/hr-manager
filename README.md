# HR Manager

Web-based HR software for small and medium-sized businesses in Vietnam. Employee records, leave, attendance, payroll
and reports in one place.

> **Status:** requirements analysis is done; the prototype ([#52](https://github.com/pbaodev/hr-manager/issues/52)) and
> the architecture design ([#8](https://github.com/pbaodev/hr-manager/issues/8)) are in progress. There is no code yet.
> Updated 2026-11-03.
>
> The detailed documentation in [docs/](docs/README.md) is written in Vietnamese.

## Project Overview

### Problem

HR work in small companies runs into a few recurring problems:

- Leave requests are sent over Zalo and approved in conversation, so it is hard to track a request's status and how
  many days of leave are left.
- HR collects attendance from chat messages and calculates pay across several Excel files, which takes time to
  reconcile and is error-prone.
- The same questions about policies, leave and payslips come up again and again, and HR answers each person
  individually.
- Employees are not sure which leave type to choose, so requests often have to be corrected and sent again.
- Managers do not follow reports regularly, so problems are spotted late.

### Solution

HR Manager brings employee records, leave, attendance and payroll into one system. Employees send requests and look
up their own information; managers approve requests; HR closes timesheets and calculates pay according to company
policy and labour law.

| Area | What it covers |
|---|---|
| HR management | Employee records, leave, attendance and payroll; permissions for viewing and actions |
| Automation | Monthly leave accrual, carried-over leave, approval reminders and alerts when a department is short-staffed |
| AI support | Help with leave requests, report analysis and answers to policy questions |

| AI assistant | What it does |
|---|---|
| AI Leave Coordinator | Drafts a request from the employee's description, suggests the right leave type and helps the manager check staffing before approving |
| AI Report Analyst | Points out what stands out in a report and explains the numbers |
| AI HR Assistant | Answers policy questions with sources; hands the question to HR when no source fits |

AI only makes suggestions; every change to data needs the user's confirmation. ID card numbers, bank accounts, tax
codes and social insurance numbers are never sent to the AI. The system still covers every business task with AI
turned off.

Details are in the [brief](docs/project/brief.md#solution) and BR-155 to BR-165 in [domain](docs/analysis/domain.md).

### Target users

| Role | Uses it to |
|---|---|
| Employee | Send leave requests, attendance corrections and overtime requests; see their leave balance, timesheet and payslips; ask about policies |
| Manager | Department heads. Approve requests; see records, team leave calendar, timesheets and reports for their department and its sub-departments |
| HR | Manage employee records, contracts, departments and accounts; close timesheets; run payroll; answer questions |

The director uses the Manager role with the whole company in scope. Permissions for each action are in the
[permission matrix](docs/analysis/requirements.md#permission-matrix).

## Product Mind Map

![HR Manager product mind map](docs/design/product-mindmap-en.png)

[Vietnamese version](docs/design/product-mindmap-vi.png) · [Xmind outline](docs/design/product-mindmap.md)

## Key Features

v1.0 is the first release delivered to the company. It includes all six milestones, built in order. AI comes last, once
the business features work correctly.

| Milestone | Features | Stories (Must) |
|---|---|---|
| M1 Organization and people | Accounts and roles; departments, job titles, org chart; employee records, contracts, job changes, departures; policies, questions to HR; notifications | 29 (20) |
| M2 Leave | Send, change, cancel and approve requests; leave balance; team leave calendar; short-staffing alerts; automatic accrual and approval reminders | 24 (18) |
| M3 Attendance | Shifts, time-clock file import, attendance corrections, overtime, closing the timesheet | 17 (14) |
| M4 Payroll and benefits | Salary, allowances, social insurance, personal income tax; monthly payroll; payslips; bank transfer file | 16 (13) |
| M5 Reports | Overview; workforce, leave, attendance and payroll reports; alerts and weekly summary | 14 (9) |
| M6 AI | AI Leave Coordinator, AI Report Analyst, AI HR Assistant | 20 (11) |

120 stories in total, 85 of them `Must`. The full list is in [stories](docs/analysis/stories.md#summary).

## Tech Stack and Architecture

| Part | Choice | Decision |
|---|---|---|
| Architecture | Modular monolith: one backend split into business modules, one web client, deployed together | [ADR-0007](docs/decisions/0007-architecture-style.md) |
| Web client | React, TypeScript | [ADR-0008](docs/decisions/0008-stack.md) |
| Backend | Python, FastAPI; scheduled jobs run in a worker from the same codebase | [ADR-0008](docs/decisions/0008-stack.md) |
| Database | PostgreSQL, also used for the job queue and policy search | [ADR-0009](docs/decisions/0009-data-storage.md) |
| Authentication | Employee ID and password; server-side sessions in an `HttpOnly` cookie | [ADR-0010](docs/decisions/0010-authentication.md) |
| Hosting | Not chosen yet; waiting on whether employee data may be stored outside Vietnam (Q-035) | [ADR-0011](docs/decisions/0011-hosting.md), Proposed |
| AI service | Not chosen yet; chosen after the AI spikes ([#48](https://github.com/pbaodev/hr-manager/issues/48), [#49](https://github.com/pbaodev/hr-manager/issues/49)) | [AI component](docs/design/ai.md) |

### System Architecture

The C4 Container view. The context view, architecture drivers and constraints are in [ARCHITECTURE.md](ARCHITECTURE.md).

```mermaid
flowchart LR
  user["Employee, Manager, HR<br/>[Person]"] -->|"HTTPS"| web["web<br/>[React, TypeScript SPA]"]
  web -->|"JSON / HTTPS, session cookie"| api["api<br/>[Python, FastAPI]"]
  api -->|"SQL"| db[("db<br/>[PostgreSQL]")]
  worker["worker<br/>[Python, same codebase as api]"] -->|"SQL; job queue"| db
  api -->|"HTTPS, filtered data"| ai["AI service<br/>[External system]"]
  worker -->|"HTTPS, filtered data"| ai
```

- **web** shows the screens for all three roles; employee screens are designed for phones. It holds no business rules.
- **api** signs users in, checks permissions on every operation and enforces the business rules of all six modules
  inside database transactions.
- **worker** runs scheduled jobs: leave accrual, effective dates, reminders, the nightly signal calculation and the
  weekly summary.
- **AI service** only receives the fields a task needs; ID card numbers, bank accounts, tax codes and social insurance
  numbers are never sent. Every call has a timeout and a template fallback, so the business features keep working.

The time clock and the bank are not connected: HR uploads the time-clock file and downloads the bank transfer file.

## Project Structure

There is no code yet. The list of documents and the status of each file are in [docs/README.md](docs/README.md).

```text
ARCHITECTURE.md        C4 Context and Container, drivers, cross-cutting concerns, threats, deployment; template, filled in Phase 3
AGENTS.md              Instructions for AI agents
contracts/
  openapi.yaml         API contract; template, filled in Phase 3
docs/
  README.md            Index: which document answers which question, and its status
  project/             Project, problem, research, questions waiting for the company
  analysis/            Requirements, user stories, INVEST, business rules, screens
  design/              Prototype, mock data, screenshots, product mind map; components, data, API, UI, AI filled in Phase 3
  decisions/           ADRs
  build/               SPEC, setup, testing, conventions
  operations/          Runbook
  playbook/            How the project is run
scripts/               GitHub setup scripts
.github/               Issue and PR templates, CI
```

## Documentation

### Requirements

- [Requirements](docs/analysis/requirements.md): 3 roles, a permission matrix, 20 use cases, 12 quality attributes.
- [Domain](docs/analysis/domain.md): 221 business rules (`BR-xxx`) and 142 edge cases (`EC-xxx`).

**Use case diagram**

```mermaid
flowchart TB
  HR["HR"]
  QL["Manager"]
  NV["Employee"]
  G1(["<b>Organization and people</b><br/>UC-001 to UC-004"])
  G4(["<b>Payroll</b><br/>UC-010 to UC-012"])
  G6(["<b>AI Report Analyst</b><br/>UC-016, UC-017"])
  G3(["<b>Attendance</b><br/>UC-007 to UC-009"])
  G2(["<b>Leave</b><br/>UC-005, UC-006"])
  G5(["<b>AI Leave Coordinator</b><br/>UC-013 to UC-015"])
  G7(["<b>AI HR Assistant</b><br/>UC-018 to UC-020"])
  TG["Time"]
  MCC["Time clock"]
  HR --- G1
  HR --- G4
  HR --- G6
  HR --- G3
  HR --- G2
  HR --- G5
  HR --- G7
  QL --- G4
  QL --- G6
  QL --- G3
  QL --- G2
  QL --- G5
  QL --- G7
  NV --- G3
  NV --- G2
  NV --- G5
  NV --- G7
  G1 --- TG
  G6 --- TG
  G3 --- TG
  G2 --- TG
  G5 --- TG
  G3 --- MCC
```

| Group | Use cases |
|---|---|
| Organization and people | UC-001 Hire a new employee · UC-002 Record a job change · UC-003 Record a departure · UC-004 Restructure departments |
| Leave | UC-005 Send and approve leave requests · UC-006 Accrue leave and carry it over |
| Attendance | UC-007 Import the time-clock file and calculate attendance · UC-008 Request and approve overtime · UC-009 Close the monthly timesheet |
| Payroll | UC-010 Calculate and close monthly payroll · UC-011 Change an employee's salary · UC-012 View the payroll cost report |
| AI Leave Coordinator | UC-013 Request leave with AI · UC-014 Coordinate a leave request's situation · UC-015 Support the leave approver |
| AI Report Analyst | UC-016 Detect signals and create insights · UC-017 Act on what stands out on the overview |
| AI HR Assistant | UC-018 Ask the AI HR Assistant · UC-019 Move from chat to a business workflow · UC-020 Send a question to HR |

Time stands for scheduled jobs, such as the monthly leave accrual. The actors of each use case are in
[requirements](docs/analysis/requirements.md#use-cases).

**User stories INVEST**

The 85 `Must` stories were checked against INVEST:

| Criterion | Passes when | Pass |
|---|---|---|
| Independent | Needs no story from a later milestone | 85 / 85 |
| Negotiable | Says what is needed, not how to build it | 85 / 85 |
| Valuable | Says clearly who benefits and how | 85 / 85 |
| Estimable | No open question blocks the story | 82 / 85 |
| Small | Can be done in about 3 working days | 74 / 85 |
| Testable | Every acceptance criterion can be checked | 85 / 85 |

72 stories pass all six criteria; the other 13 already have Issues to fix them. Results are in the
[INVEST review](docs/analysis/invest.md), which is still Draft.

### Information Architecture

52 screens, grouped by menu. Each user sees only the items they have permission for. The full map of all 52 screens is
in [UI flow](docs/analysis/ui-flow.md#information-architecture).

```mermaid
flowchart LR
  HOME["Home"]
  HOME --> ME["My profile"]
  HOME --> DIR["Directory, Org chart"]
  HOME --> EMP["Employees<br/>records, contracts, new hire, departure"]
  HOME --> APR["Approvals"]
  HOME --> LV["Leave<br/>my leave, request leave, team leave calendar"]
  HOME --> AT["Attendance<br/>timesheet, corrections, overtime, close timesheet"]
  HOME --> PY["Pay<br/>payslips, payroll"]
  HOME --> RP["Reports<br/>overview, reports, signal details"]
  HOME --> POL["Policies"]
  HOME --> HQ["Questions to HR"]
  HOME --> ADM["Admin<br/>departments, accounts, leave types, shifts, payroll settings"]
  CHAT["AI HR Assistant chat<br/>opens from any screen"] -.- HOME
```

### Architecture documents

| Document | Status |
|---|---|
| C4 Context and Container, drivers, constraints: [ARCHITECTURE.md](ARCHITECTURE.md) | Draft ([#8](https://github.com/pbaodev/hr-manager/issues/8)) |
| Architecture decisions: [ADR index](docs/decisions/README.md) | ADR-0007 to ADR-0010 Accepted; ADR-0011 Proposed |
| C4 Component and module rules: [components](docs/design/components.md) | Not started ([#11](https://github.com/pbaodev/hr-manager/issues/11)) |
| Data model: [data](docs/design/data.md), [schema.dbml](docs/design/schema.dbml) | Draft ([#9](https://github.com/pbaodev/hr-manager/issues/9)) |
| API (OpenAPI): [api](docs/design/api.md), [openapi.yaml](contracts/openapi.yaml) | Draft ([#10](https://github.com/pbaodev/hr-manager/issues/10)): operation map for every Must story; contract written for M1 |

### Data Model

54 PostgreSQL tables, designed from the entities and business rules in [domain](docs/analysis/domain.md). Every
column is in [schema.dbml](docs/design/schema.dbml); conventions, constraints and transactions are in
[data](docs/design/data.md). The diagram shows the core tables only.

```mermaid
erDiagram
  employees ||--|{ assignments : "job history"
  assignments }o--|| org_units : "in"
  employees ||--o{ employment_contracts : "signs"
  employees ||--o| user_accounts : "signs in with"
  employees ||--o{ leave_requests : "sends"
  employees ||--o{ leave_ledger_entries : "leave ledger"
  employees ||--o{ attendance_days : "attendance"
  employees ||--|{ salary_records : "salary history"
  payroll_runs ||--o{ payslips : "contains"
  payslips }o--|| employees : "for"
  signals ||--o{ signal_reactions : "reactions"
```

Rules that must hold even when two people act at the same time are kept in the database: effective-dated records
(job history, contracts, salary) cannot overlap, leave requests cannot overlap by half-day, and the leave ledger is
append-only. Leave and overtime actions for one employee run one at a time under a row lock.

### API

REST over HTTPS with JSON, under `/api/v1`. The contract in [openapi.yaml](contracts/openapi.yaml) is written before
the code and linted in CI; once the backend exists, CI compares the schema FastAPI generates with the contract.

| Topic | Convention |
|---|---|
| Sign-in | Session cookie (`HttpOnly`); every write sends an `X-CSRF-Token` header |
| Permissions | Checked on the backend for every operation, by role and department scope; objects outside the caller's scope return `404` |
| Errors | RFC 9457 Problem Details with a stable `code` that points to a business rule, such as `contract_overlap` (BR-025) |
| Concurrency | Editable records return an `ETag`; updates send `If-Match` |
| Retries | Creating requests, importing files and running payroll accept an `Idempotency-Key` |
| AI | AI operations return `503 ai_unavailable` when the AI service fails; the screen falls back to forms and templates |

The contract covers M1 (46 operations: sign-in, accounts, departments, employees, contracts, policies, questions to
HR, notifications). M2 to M6 follow the operation map in [api.md](docs/design/api.md).

### UI/UX Prototype

The prototype uses mock data from [prototype-data](docs/design/prototype-data.md). Employee screens are drawn for a
phone; Manager and HR screens for a 1440 px web layout.

<table>
<tr>
<td width="50%"><img src="docs/design/screenshots/scr-003-hr.png" alt="Home for HR: pending approvals, contracts ending soon and notifications"><br><b>Home · HR</b></td>
<td width="50%"><img src="docs/design/screenshots/scr-021-quan-ly.png" alt="Approvals for a manager, with the AI summary of a leave request"><br><b>Approvals · Manager, with the AI summary</b></td>
</tr>
<tr>
<td width="50%"><img src="docs/design/screenshots/scr-040-giam-doc.png" alt="Reports overview for the director, with AI insights"><br><b>Reports overview · Director, with AI insights</b></td>
<td width="50%" align="center"><img src="docs/design/screenshots/scr-020-nv.png" alt="Request leave on an employee's phone, filled in by the AI Leave Coordinator" width="220"><br><b>Request leave · Employee phone, with AI</b></td>
</tr>
</table>

Every screen drawn so far is in [docs/design/screenshots/](docs/design/screenshots/). The plan for which screens are
drawn and how they are reviewed is in [prototype.md](docs/design/prototype.md).

The workflow is described in the [playbook](docs/playbook/README.md); instructions for AI agents are in
[AGENTS.md](AGENTS.md).

## License

[MIT](LICENSE)
