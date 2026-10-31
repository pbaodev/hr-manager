# HR Manager

Hệ thống quản lý nhân sự chạy trên web cho doanh nghiệp nhỏ và vừa tại Việt Nam.

> **Trạng thái:** đang đổi phạm vi ([#39](https://github.com/pbaodev/hr-manager/issues/39)). v1.0 gồm M1–M6, AI là
> trọng tâm; bước tiếp theo là UI prototype dùng dữ liệu giả, chưa có code. Stack và thiết kế được chọn lại sau
> prototype. Các mục dưới đây vẫn mô tả phạm vi MVP cũ và sẽ được viết lại sau khi có prototype. Cập nhật 2026-10-31.

## Project Overview

HR Manager gom hồ sơ nhân viên, cơ cấu tổ chức, nghỉ phép, chấm công, lương và báo cáo vào một hệ thống, thay cho tin
nhắn Zalo và các bảng tính rời rạc.

### Problem

Ở công ty mục tiêu, nhân viên xin nghỉ qua Zalo hoặc nói trực tiếp, và quản lý duyệt bằng lời. Không nơi nào ghi lại số
ngày phép đã dùng, nên cả nhân viên lẫn HR đều không biết mỗi người còn bao nhiêu ngày. Cuối tháng HR lục lại tin nhắn
để tính công, rồi tính lương trên nhiều bảng tính. Kết quả là công và lương dễ sai, và hai bên hay tranh cãi về số ngày
phép.

Đây là nhận định của chủ dự án, chưa được công ty xác nhận. Các câu cần hỏi công ty nằm ở
[questions](docs/project/questions.md).

### Solution

Các ý dưới đây có trong MVP, trừ hai ý ghi "Sau MVP".

- Nhân viên tự gửi đơn nghỉ và xem số ngày phép còn lại, kể cả trên điện thoại.
- Quản lý duyệt đơn ngay trên hệ thống và thấy lịch nghỉ của nhóm.
- Hệ thống tự cộng phép hằng tháng, chuyển phép tồn, và tính số ngày nghỉ theo lịch làm việc và ngày lễ.
- HR quản lý hồ sơ, hợp đồng và cơ cấu tổ chức ở một nơi, có lịch sử theo ngày hiệu lực.
- Mỗi người chỉ thấy dữ liệu theo vai trò của mình; Quản lý chỉ thấy nhân viên của các phòng ban mình phụ trách.
- Quản lý và HR xem báo cáo nhân sự, nghỉ phép và xuất ra bảng tính.
- Sau MVP, chấm công: HR nhập file từ máy chấm công; hệ thống tính công, đi muộn, về sớm, làm thêm giờ, rồi HR chốt
  bảng công tháng. Nhân viên xem bảng công, gửi giải trình và đăng ký làm thêm trên hệ thống.
- Sau MVP, lương: hệ thống tính lương từ bảng công đã chốt, gồm phụ cấp, làm thêm, BHXH và thuế TNCN; nhân viên xem
  phiếu lương. Báo cáo có thêm chấm công và chi phí lương.
- Mọi tỷ lệ và mức theo luật lao động, BHXH, thuế là tham số có ngày hiệu lực; HR cập nhật khi luật đổi mà không cần
  sửa code.

### Target users

| Vai trò | Ai | Dùng hệ thống để |
|---|---|---|
| Nhân viên | Mọi người có tài khoản | Xem và sửa thông tin liên hệ của mình, gửi và hủy đơn nghỉ, xem số dư phép. Sau MVP: xem bảng công, gửi giải trình, đăng ký làm thêm, xem phiếu lương |
| Quản lý | Trưởng phòng ban, tự có khi được bổ nhiệm; giám đốc là trưởng phòng ban gốc | Duyệt đơn của nhóm, xem hồ sơ và lịch nghỉ trong phạm vi, xem báo cáo. Sau MVP: duyệt giải trình và làm thêm, xem bảng công của nhóm, xem chi phí lương ở mức tổng hợp |
| HR | Người làm nhân sự, được gán vai trò | Quản lý hồ sơ, hợp đồng, cơ cấu, tài khoản, loại nghỉ, lịch làm việc; duyệt thay. Sau MVP: nhập chấm công, chốt bảng công, tính và chốt bảng lương |

Quyền chi tiết của từng thao tác nằm ở [permission matrix](docs/analysis/requirements.md#permission-matrix).

## Product Mind Map

![Product mind map]()

## Key Features

MVP là bản phát hành đầu tiên, gồm 32 trên 72 user story. MVP giải chỗ đau xin nghỉ trước, để công ty dùng thử sớm, trước
hai milestone có nhiều rủi ro về luật là chấm công và lương.

| Milestone | Tính năng | MVP |
|---|---|---|
| M1 Nhân sự và tổ chức | Đăng nhập, đổi mật khẩu; quản lý tài khoản và vai trò HR | ✅ |
| | Phòng ban có lịch sử theo ngày hiệu lực, chức danh, bổ nhiệm trưởng phòng ban, sơ đồ tổ chức | ✅ |
| | Tiếp nhận nhân viên, sửa hồ sơ, tìm và lọc nhân viên, thay đổi công tác, nghỉ việc, hợp đồng và hợp đồng sắp hết hạn | ✅ |
| | Nhân viên tự xem và sửa thông tin liên hệ; Quản lý xem hồ sơ trong phạm vi | ✅ |
| | Nhật ký thao tác, giải thể phòng ban, cơ cấu tại ngày trong quá khứ, danh bạ, nhập từ bảng tính, tuyển lại, xóa dữ liệu hết hạn lưu | Sau |
| M2 Nghỉ phép | Số dư và biến động phép; gửi, hủy, duyệt, từ chối đơn nghỉ; HR duyệt thay | ✅ |
| | Lịch nghỉ nhóm, loại nghỉ, lịch làm việc, cộng phép tháng, chuyển phép tồn, điều chỉnh phép, thông báo | ✅ |
| | HR ghi đơn thay nhân viên, số phép chưa nghỉ khi nghỉ việc | Sau |
| M3 Chấm công | Ca, gán ca, nhập file máy chấm công, tính công, giải trình, làm thêm giờ, chốt bảng công | Sau |
| M4 Lương | Lương và phụ cấp theo ngày hiệu lực, BHXH, thuế TNCN, người phụ thuộc, tính và chốt bảng lương, phiếu lương | Sau |
| M5 Báo cáo | Trang tổng quan, biến động nhân sự, nghỉ phép, xuất bảng tính | ✅ |
| | Cơ cấu nhân sự, chấm công, chi phí lương | Sau |
| M6 AI | Hướng mở rộng sau M1 tới M5 | Sau |

Danh sách story đầy đủ ở [stories](docs/analysis/stories.md#summary).

## Project Structure

Code backend và frontend sẽ được thêm khi dựng khung dự án (Issue #14). Danh mục đầy đủ của tài liệu ở
[docs/README.md](docs/README.md).

```text
ARCHITECTURE.md        C4 Context và Container, driver, cross-cutting, threat, deployment; mẫu, điền ở Phase 3
AGENTS.md              Hướng dẫn cho AI agent
contracts/
  openapi.yaml         Contract API; mẫu, điền ở Phase 3
docs/
  README.md            Index: tài liệu nào trả lời câu hỏi nào, trạng thái ra sao
  project/             Dự án, bài toán, nghiên cứu, câu hỏi chờ công ty xác nhận
  analysis/            Requirements, user story, INVEST, luật nghiệp vụ, màn hình
  design/              Component, data, API, flow, UI, AI; mẫu, điền ở Phase 3
  decisions/           ADR
  build/               SPEC, setup, testing, conventions
  operations/          Runbook
  playbook/            Quy trình làm việc của dự án
scripts/               Script dựng GitHub
.github/               Mẫu Issue và PR, CI
```

## Documentation

### Requirements

[Requirements](docs/analysis/requirements.md) có 3 actor người, ma trận quyền, 12 use case và 5 quality attribute.
[Domain](docs/analysis/domain.md) có 141 luật nghiệp vụ và 91 edge case, mỗi luật có mã `BR-xxx` để truy tới story và test.

**Use case diagram**

![Use case diagram]()

**User stories INVEST**

Có 72 story, mỗi story kèm acceptance criteria dạng Given, When, Then. 32 story của MVP được chấm theo rubric INVEST:

| Criterion | Pass khi | Pass |
|---|---|---|
| Independent | Làm và kiểm được trong MVP, không cần story ngoài MVP | 30 / 32 |
| Negotiable | Nói người dùng cần gì, không áp đặt cách làm | 32 / 32 |
| Valuable | Có vai trò rõ và lợi ích cho vai trò đó | 32 / 32 |
| Estimable | Luật và edge case đã có mã, không còn câu hỏi mở chặn story | 32 / 32 |
| Small | Làm xong backend, frontend và test trong một PR, khoảng 3 ngày công | 29 / 32 |
| Testable | Mọi AC kiểm được | 32 / 32 |

27 story đạt đủ sáu tiêu chí. Năm story còn lại và cách sửa đề xuất nằm ở [INVEST review](docs/analysis/invest.md).

### Information Architecture

46 màn hình, nhóm theo menu. Menu chỉ hiện mục người dùng có quyền; quyền vẫn được kiểm ở backend.

![Information architecture]()

Luồng giữa các màn hình ở [UI flow](docs/analysis/ui-flow.md).

Dự án làm theo [playbook](docs/playbook/README.md) sáu phase; AI agent làm việc theo [AGENTS.md](AGENTS.md).

## License

[MIT](LICENSE)
