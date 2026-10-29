# Runbook: [tên dự án]

- **Status:** [Draft | Accepted | Superseded]
- **Updated:** [YYYY-MM-DD]
- **Related:** [ARCHITECTURE](../ARCHITECTURE.md#deployment) · [setup](setup.md) · [testing](testing.md) ·
  [phases](playbook/phases.md)

> Chuẩn bị từ Phase 3, hoàn thiện trước bản production đầu tiên (Phase 5). Mỗi thủ tục ghi từng bước kèm lệnh cụ thể,
> đủ để làm theo lúc đang có sự cố. Không ghi secret; chỉ ghi nơi lưu secret. Thủ tục nào chưa thử thì ghi rõ ở cột
> Last tested. Dòng in nghiêng là ví dụ, xóa khi điền.

## Environments

| Environment | URL | Runs on | Health check |
|---|---|---|---|
| *staging* | *[URL]* | *[hosting]* | *[endpoint hoặc lệnh]* |
| *production* | *[URL]* | *[hosting]* | *[endpoint hoặc lệnh]* |

## Procedures

| Procedure | Last tested |
|---|---|
| [Deploy](#deploy) | *[YYYY-MM-DD]* |
| [Rollback](#rollback) | *[YYYY-MM-DD]* |
| [Restore backup](#restore-backup) | *[YYYY-MM-DD]* |
| [Rotate a key](#rotate-a-key) | *[YYYY-MM-DD]* |

### Deploy

1. [bước, kèm lệnh]

**Smoke test sau deploy:** [các bước kiểm nhanh, ví dụ health check, đăng nhập, mở một màn hình chính]

### Rollback

1. [bước, kèm lệnh. Migration không tương thích ngược thì ghi cách xử lý dữ liệu]

### Restore backup

- **Schedule and retention:** [theo mục Retention and backup trong [data design](design/data.md)]

1. [bước, kèm lệnh]

### Rotate a key

1. [tạo key mới, cập nhật nơi lưu secret, deploy, thu hồi key cũ]

## Monitoring

| Signal | Alert threshold | Where to look |
|---|---|---|
| *Error rate* | *[ngưỡng]* | *[công cụ error tracking]* |
| *Uptime* | *Down quá 2 phút* | *[công cụ uptime]* |
| *Chi phí* | *[ngưỡng mỗi tháng]* | *[trang billing]* |

## Known incidents

| Symptom | Cause | Fix |
|---|---|---|
| | | |

## Contacts

Chỉ cần khi có người khác cùng vận hành hoặc có nhà cung cấp phải liên hệ.

| Role | Who | Channel |
|---|---|---|
| | | |
