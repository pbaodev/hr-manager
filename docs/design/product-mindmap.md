# Product mindmap: hr-manager

- **Status:** Draft
- **Updated:** 2026-11-02
- **Reviewed:** Chưa review
- **Related:** [research](../project/research.md#decomposition) · [brief](../project/brief.md#scope) · [prototype](prototype.md)

Dàn ý để dựng product mindmap bằng Xmind cho slide báo cáo dự án ở #68. Phân rã chức năng chính thức nằm ở mục
Decomposition của [research](../project/research.md#decomposition); file này chỉ là bản rút gọn để trình bày. Hai bên
khác nhau thì research đúng.

## How to use

- Dán một khối dưới đây vào ô tạo mindmap từ Markdown của Xmind. `#` là chủ đề trung tâm, `##` là nhánh chính, `-` là
  nhánh con.
- Dòng bắt đầu bằng `Tự động:` hoặc `Auto:` là tự động hóa theo quy tắc, không dùng AI. Tô màu riêng hoặc gắn marker.
- Ba nhánh có tên bắt đầu bằng `AI` là tính năng AI ở M6. Tô màu xanh, viền nét đứt, đặt cạnh nhánh mà nó dựa vào:
  Leave Coordinator cạnh Nghỉ phép, Report Analyst cạnh Báo cáo và phân tích, HR Assistant cạnh Quy chế và hỗ trợ.

## Vietnamese

```markdown
# HR Manager · Quản lý nhân sự có AI hỗ trợ

## Tổ chức và nhân sự
- Phòng ban và chức danh
- Sơ đồ tổ chức
- Hồ sơ nhân viên
- Hợp đồng lao động
- Nhân viên tự cập nhật hồ sơ

## Nghỉ phép
- Gửi, đổi, hủy đơn
- Duyệt đơn
- Số dư phép
- Lịch nghỉ của nhóm
- Cảnh báo thiếu người
- Tự động: cộng phép hằng tháng, chuyển phép tồn
- Tự động: nhắc duyệt, giao người duyệt thay

## AI Leave Coordinator
- Tạo đơn từ một câu
- Đề xuất phương án nghỉ
- Giải thích tình huống của đơn
- Tóm tắt cho người duyệt

## Chấm công
- Ca làm việc
- Nhập file chấm công
- Giải trình chấm công
- Làm thêm giờ
- Chốt bảng công
- Tự động: cờ đi muộn, gần giới hạn làm thêm

## Lương và phúc lợi
- Lương và phụ cấp
- Bảo hiểm và thuế TNCN
- Bảng lương tháng
- Phiếu lương
- Chuyển khoản lương

## Quản trị hệ thống
- Tài khoản và đăng nhập
- Phân quyền theo vai trò
- Nhật ký thao tác
- Xóa dữ liệu hết hạn lưu

## AI Report Analyst
- Gom tín hiệu thành insight
- Giải thích con số
- Soạn thẻ nhắc nhóm

## Báo cáo và phân tích
- Trang tổng quan
- Báo cáo nhân sự
- Báo cáo công và lương
- Thẻ cảnh báo
- Tóm tắt tuần
- Tự động: tính tín hiệu hằng đêm

## Quy chế và hỗ trợ
- Thư viện quy chế
- Câu hỏi thường gặp
- Câu hỏi gửi HR
- Thông báo
- Tự động: nhắc HR trả lời câu hỏi

## AI HR Assistant
- Hỏi đáp quy chế
- Tra dữ liệu cá nhân
- Mở đúng màn hình
- Chuyển câu hỏi cho HR
```

## English

```markdown
# HR Manager · HR management with AI support

## Organization & people
- Departments and job titles
- Org chart
- Employee profiles
- Employment contracts
- Employee self-service profile updates

## Leave
- Submit, change, cancel requests
- Approve requests
- Leave balances
- Team leave calendar
- Low-coverage warnings
- Auto: monthly accrual, carry-over
- Auto: approval reminders, backup approver

## AI Leave Coordinator
- Request from one sentence
- Leave option suggestions
- Explanations for request situations
- Summary for approvers

## Attendance
- Shifts
- Time-clock file import
- Attendance explanations
- Overtime
- Timesheet closing
- Auto: late-arrival and overtime-limit flags

## Payroll & benefits
- Pay and allowances
- Insurance and personal income tax
- Monthly payroll
- Payslips
- Salary bank transfer

## System administration
- Accounts and sign-in
- Role-based access
- Audit log
- Deleting data past retention

## AI Report Analyst
- Group signals into insights
- Explain numbers
- Draft team reminders

## Reports & analytics
- Overview dashboard
- HR reports
- Time and pay reports
- Alert cards
- Weekly summary
- Auto: nightly signal calculation

## Policies & support
- Policy library
- FAQ
- Questions to HR
- Notifications
- Auto: reminders for unanswered HR questions

## AI HR Assistant
- Policy Q&A
- Personal data lookup
- Open the right screen
- Send question to HR
```
