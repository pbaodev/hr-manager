# Setup: [tên dự án]

- **Status:** [Draft | Accepted | Superseded]
- **Updated:** [YYYY-MM-DD]
- **Related:** [SPEC](SPEC.md#commands) · [ARCHITECTURE](../../ARCHITECTURE.md#deployment) · [runbook](../operations/runbook.md)

> Điền ở Phase 3, khi cấu hình `make setup` và `make check`; cập nhật trong cùng PR với thay đổi môi trường. File này
> giúp người mới, kể cả chính mình sau vài tháng, chạy được dự án trên máy sạch trong 30 phút. Lệnh hằng ngày nằm ở mục
> Commands của SPEC; deploy và vận hành nằm ở runbook. Dòng in nghiêng là ví dụ, xóa khi điền.

## Prerequisites

| Tool | Version | Check |
|---|---|---|
| *Git* | *≥ 2.40* | *`git --version`* |
| *[runtime]* | *[version]* | *[lệnh kiểm]* |

## First run

1. Clone repo và vào thư mục dự án.
2. `cp .env.example .env`, rồi điền giá trị theo mục Environment variables.
3. `make setup`
4. [lệnh chạy dịch vụ phụ thuộc như DB, nếu có]
5. [lệnh migration và seed]
6. [lệnh chạy ứng dụng]; mở [địa chỉ local].
7. `make check` để xác nhận môi trường chạy đúng.

## Environment variables

Mỗi biến trong `.env.example` có một dòng. Secret không ghi giá trị ở đây; nơi lưu secret ghi ở mục Tools của
[project.md](../project/project.md).

| Variable | Meaning | Example | Required |
|---|---|---|---|
| *`APP_ENV`* | *Môi trường đang chạy* | *`development`* | *Có* |
| *`MAX_BOOKING_HOURS`* | *Giá trị của `max_booking_hours` (BR-002)* | *`4`* | *Không, default 4* |

## Demo accounts

Chỉ cho local và staging, tạo bằng sample data. Không ghi tài khoản hay mật khẩu production.

| Role | Account | Notes |
|---|---|---|
| *Thành viên* | *[tài khoản]* | *[ghi chú]* |

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| | | |

## Verified

| Date | Machine or container | Time to first run | Notes |
|---|---|---|---|
| *[YYYY-MM-DD]* | *[máy sạch hoặc container]* | *[phút]* | *[bước nào vướng]* |
