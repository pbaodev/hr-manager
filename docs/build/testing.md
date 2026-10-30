# Testing: [tên dự án]

- **Status:** [Draft | Accepted | Superseded]
- **Updated:** [YYYY-MM-DD]
- **Related:** [SPEC](SPEC.md#test-strategy) · [stories](../analysis/stories.md) · [requirements](../analysis/requirements.md) ·
  [phases](../playbook/phases.md)

> Tạo ở Phase 3; cập nhật ở mỗi Feature loop và mỗi lần đóng milestone. Test strategy (tầng nào kiểm gì, chạy ở đâu)
> nằm ở SPEC; file này ghi phần không nằm trong code: test case thủ công, mức lỗi và kết quả test của từng bản phát
> hành. Test tự động nối với yêu cầu qua Traceability trong SPEC. Dòng in nghiêng là ví dụ, xóa khi điền.

## Environments and data

- **Release testing:** [staging, hoặc local khi dự án không có staging]
- **Data:** [sample data hoặc script tạo dữ liệu; không dùng dữ liệu thật của người dùng]
- **Accounts:** mỗi actor người có một tài khoản test, ghi ở Demo accounts trong [setup](setup.md).

## Manual test cases

Chỉ ghi ca không tự động hóa được hoặc dùng để nghiệm thu. Mỗi ca dẫn tới acceptance criteria hay quality attribute
mà nó kiểm.

| ID | Covers | Steps | Expected |
|---|---|---|---|
| *TC-001* | *US-001 AC2* | *1. Đặt phòng A 9:00–10:00. 2. Ở trình duyệt khác, đặt phòng A 9:30–10:30.* | *Lần đặt thứ hai bị từ chối, có thông báo trùng lịch và gợi ý giờ khác* |
| *TC-002* | *QA-001* | *Chạy load test 50 người dùng mở lịch tuần trên staging* | *p95 < 500 ms* |

## Defect severity

Mỗi Bug ghi một mức. S1 là sự cố Severe theo mục Incident ở Phase 5 trong [phases.md](../playbook/phases.md).

| Severity | Meaning | Handling |
|---|---|---|
| S1 Critical | Hệ thống dừng; mất, sai hoặc lộ dữ liệu; sai tiền hoặc sai quyền | Xử lý ngay; chặn phát hành |
| S2 Major | Chức năng chính sai, không có cách khắc phục tạm | Sửa trong milestone hiện tại; chặn phát hành |
| S3 Minor | Chức năng sai nhưng có cách khắc phục tạm | Xếp vào milestone theo priority |
| S4 Trivial | Lỗi hiển thị, chính tả | Khi có thời gian |

## Release test log

Mỗi lần đóng milestone một dòng, ghi lúc chạy release gate. Kết quả từng ca thủ công và từng quality attribute ghi ở
bảng chi tiết bên dưới.

| Version | Date | Environment | Automated (unit / integration / E2E) | Manual cases | Open S1, S2 | Decision |
|---|---|---|---|---|---|---|
| *v0.1.0* | *[YYYY-MM-DD]* | *staging* | *120 / 35 / 8 pass* | *TC-001, TC-002 pass* | *0* | *Release* |

### [version]: details

| Item | Target | Result | Pass |
|---|---|---|---|
| *QA-001* | *p95 < 500 ms* | *p95 = 410 ms* | *✅* |
| *TC-001* | *Từ chối đặt trùng* | *Đúng như mong đợi* | *✅* |

## Acceptance sign-off

Chỉ dùng cho dự án loại Client delivery. Bên nhận chạy test case nghiệm thu trên bản release candidate rồi xác nhận.

| Version | Name | Date | Cases run | Result |
|---|---|---|---|---|
| [v1.0.0-rc.N] | [họ tên] | [YYYY-MM-DD] | [TC-xxx] | [Accepted / Cần sửa: #issue] |
