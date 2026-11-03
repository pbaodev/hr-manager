# UI design

- **Status:** [Draft | Accepted | Superseded]
- **Updated:** [YYYY-MM-DD]
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Related:** [UI flow](../analysis/ui-flow.md) · [components](components.md) · [api](api.md) ·
  [design guide](../playbook/design.md)

> Điền ở Phase 3 khi sản phẩm có giao diện; nếu không thì bỏ file. UI flow ghi người dùng thấy gì và đi qua màn hình
> nào; file này ghi quy tắc giao diện chung cho mọi màn hình: design system, trạng thái, định dạng và accessibility.
> Cách xây frontend nằm ở mục Frontend của components. Màn hình nào làm khác quy tắc chung thì ghi ở mục màn hình đó
> trong UI flow. Dòng in nghiêng là ví dụ, xóa khi điền.

## Design sources

| Kind | Link | Version or date |
|---|---|---|
| Design system của prototype, Artifact loại Design System trên claude.ai, riêng tư | [HR Manager](https://claude.ai/artifact/9GgVS3B3WtVwGALVifbziA) | 2026-11-03, phiên bản 11: quy tắc Không có số và không vẽ control chưa có hành vi ở #72 |
| Canvas prototype, Artifact loại Design trên claude.ai, riêng tư | [HR Manager Prototype](https://claude.ai/artifact/Dab3WjsfCMeWuE65pHN93S) | 2026-11-02, phiên bản 17: 5 màn AI của #68 |
| *Mockup* | *[link]* | *[YYYY-MM-DD]* |
| *Component library* | *[tên thư viện, dẫn ADR nếu ảnh hưởng tới kiến trúc]* | *[version]* |

## Design tokens

Giá trị dùng chung, đặt trong code hoặc config của frontend thay vì viết thẳng vào từng màn hình.

| Token | Value | Used for |
|---|---|---|
| *`color.primary`* | *[mã màu]* | *Nút chính, link* |
| *`color.danger`* | *[mã màu]* | *Lỗi, thao tác xóa* |
| *`font.size.base`* | *[16px]* | *Nội dung* |
| *`spacing.unit`* | *[4px]* | *Mọi khoảng cách là bội số của giá trị này* |

## Screen states

Áp dụng cho mọi màn hình. Màn hình chỉ cần các trạng thái có thật với nó.

| State | Required behavior |
|---|---|
| Loading | Giữ khung trang; hiện skeleton hoặc spinner ở vùng đang tải |
| Empty | Nói rõ không có dữ liệu; phân biệt "chưa có dữ liệu" với "không có kết quả khớp bộ lọc" |
| Validation error | Giữ dữ liệu đã nhập; báo lỗi ngay dưới trường; focus vào trường lỗi đầu tiên |
| Server error | Thông báo ngắn, có cách thử lại; không hiện chi tiết kỹ thuật |
| Unauthenticated | Xóa phiên, chuyển tới đăng nhập, quay lại trang cũ sau khi đăng nhập |
| Forbidden | Báo không có quyền, kèm đường quay lại |
| Saving | Khóa nút gửi để tránh gửi hai lần |
| Success | Xác nhận kết quả; tải lại dữ liệu bị ảnh hưởng |
| No value | Số không tính được thì hiện "—" kèm lý do ngắn, như nhóm dưới `report_min_group_size` người (BR-129) hay tháng chưa tính lương; không hiện 0 hay 0% thay cho số thiếu |
| AI output | Đánh dấu là gợi ý; người dùng xác nhận trước khi kết quả được dùng; bỏ dòng này khi không có tính năng AI |

## Formats

- **Language:** giao diện, thông báo và nội dung AI viết bằng tiếng Anh (quyết định của chủ dự án, 2026-11-03, #74). Tài
  liệu phân tích giữ tiếng Việt; tên trên giao diện theo mục Language and terms bên dưới. Tên người giữ nguyên tiếng
  Việt có dấu.
- **Date and time:** ngày `09/11/2026` (`dd/MM/yyyy`); trong năm hiện tại bỏ năm: `13/11`; kèm thứ: `Fri 13/11`; khoảng
  ngày `17/11 – 19/11`; buổi `13/11 AM`, `13/11 PM`. Giờ 24 giờ `08:45`. Hiển thị theo giờ Việt Nam.
- **Numbers and currency:** dấu phẩy ngăn nghìn, dấu chấm thập phân: tiền `13,717,500 VND`; số ngày `1.5 days`, `1 day`;
  tỷ lệ `21.6%`; số âm dùng dấu trừ `−1.0`. Trong bảng, đơn vị ghi ở đầu cột: `Gross pay (VND)`.
- **Responsive:** [breakpoint, ví dụ mobile ≤ 768px, desktop > 1024px; màn hình nào không hỗ trợ mobile]

## Language and terms

Một khái niệm chỉ có một tên trên giao diện. Viết hoa chữ đầu câu và tên riêng: `Request leave`, không `Request Leave`.
Cột Vietnamese là tên trong tài liệu phân tích.

**Roles and company**

| Vietnamese | English |
|---|---|
| Nhân viên, Quản lý, HR | Employee, Manager, HR |
| Giám đốc (nhãn dưới tên ở sidebar) | Director |
| Công ty Mẫu | Sample Co. |
| Kinh doanh, Kho vận, Kỹ thuật, Kế toán, Hành chính – Nhân sự, Pháp chế | Sales, Logistics, Engineering, Accounting, Admin & HR, Legal |

**Menu**

| Vietnamese | English |
|---|---|
| Trang chủ, Hồ sơ của tôi, Danh bạ, Sơ đồ tổ chức | Home, My profile, Directory, Org chart |
| Nhân viên, Đơn chờ duyệt, Nghỉ phép, Chấm công, Lương | Employees, Approvals, Leave, Attendance, Pay |
| Báo cáo, Quy chế, Câu hỏi gửi HR, Quản trị | Reports, Policies, Questions to HR, Admin |
| Tab bar điện thoại: Trang chủ, Đơn nghỉ, Bảng công, Phiếu lương, Thêm | Home, Leave, Timesheet, Payslips, More |

**Screens**

| ID | English | ID | English |
|---|---|---|---|
| SCR-001 | Sign in | SCR-027 | Import time-clock file |
| SCR-002 | Change password | SCR-028 | My timesheet |
| SCR-003 | Home | SCR-029 | Attendance correction |
| SCR-004 | My profile | SCR-030 | Overtime request |
| SCR-005 | Directory | SCR-031 | Team timesheet |
| SCR-006 | Org chart | SCR-032 | Close timesheet |
| SCR-007 | Employees | SCR-033 | Allowance types |
| SCR-008 | Employee details | SCR-034 | Payroll settings |
| SCR-009 | New hire | SCR-035 | Salary change |
| SCR-010 | Job change | SCR-036 | Dependants |
| SCR-011 | Record departure | SCR-037 | Payroll |
| SCR-012 | Add or edit contract | SCR-038 | Payslip details |
| SCR-013 | Expiring contracts | SCR-039 | My payslips |
| SCR-014 | Departments | SCR-040 | Reports overview |
| SCR-015 | Job titles | SCR-041 | Headcount changes |
| SCR-016 | User accounts | SCR-042 | Workforce mix |
| SCR-017 | Audit log | SCR-043 | Leave report |
| SCR-018 | Import employees | SCR-044 | Attendance report |
| SCR-019 | My leave | SCR-045 | Payroll cost |
| SCR-020 | Request leave | SCR-046 | Expired records |
| SCR-021 | Approvals | SCR-047 | Leave reasons |
| SCR-022 | Team leave calendar | SCR-048 | Signal details |
| SCR-023 | Leave types | SCR-049 | Policy library |
| SCR-024 | Work calendar | SCR-050 | Edit policy version |
| SCR-025 | Shifts | SCR-051 | Questions to HR |
| SCR-026 | Shift assignment | SCR-052 | HR Assistant |

**Statuses**

Theo mục Lifecycles của [domain](../analysis/domain.md#lifecycles); mã trạng thái trong domain đặt cạnh tên hiển thị.

| Object | English |
|---|---|
| Đơn nghỉ, đơn làm thêm | Pending `pending`, Approved `approved`, Rejected `rejected`, Awaiting reply `awaiting`, Cancelled `cancelled` |
| Nhân viên | Upcoming `upcoming`, Active `active`, Left `terminated`, Hire cancelled `cancelled`, Anonymized `anonymized` |
| Tài khoản | Active `active`, Temporarily locked `throttled`, Locked `locked` |
| Hợp đồng | Upcoming `upcoming`, Active `active`, Expired `expired`, Ended early `terminated` |
| Phòng ban | Planned `planned`, Active `active`, Dissolved `dissolved` |
| Bảng công | Open `open`, Closed `closed` |
| Bảng lương | Draft `draft`, Needs recalculation `stale`, Closed `closed` |
| Tín hiệu | Active `active`, Resolved `resolved` |
| Câu hỏi gửi HR | Pending `pending`, Answered `answered` |
| Nhãn khác: Quá hạn, Dưới ngưỡng, Thiếu phép, Thiếu dữ liệu, Không đồng ý đổi ngày | Overdue, Below threshold, Not enough leave, Missing data, Date change declined |

**Leave types and reasons**

| Vietnamese | English |
|---|---|
| Phép năm | Annual leave |
| Kết hôn, Con kết hôn | Marriage leave, Child's marriage leave |
| Tang cha, mẹ, vợ hoặc chồng, con… | Bereavement leave |
| Việc riêng không lương | Unpaid personal leave |
| Ốm đau, Thai sản | Sick leave, Maternity leave |
| Lý do: Bản thân kết hôn, Anh chị em ruột kết hôn, Ông bà mất… | Own wedding, Sibling's wedding, Grandparent's death… |

**Business terms**

| Vietnamese | English | Vietnamese | English |
|---|---|---|---|
| Số dư phép | Leave balance | Bảng công | Timesheet |
| Phép tồn | Carried-over leave | Chốt bảng công, chốt bảng lương | Close timesheet, close payroll |
| Cộng phép | Accrual | Giải trình | Attendance correction |
| Người duyệt, duyệt thay | Approver, backup approver | Làm thêm giờ | Overtime |
| Đề nghị đổi ngày | Suggest other dates | Ca làm việc | Shift |
| Ngưỡng nhân sự, mức phủ | Staffing threshold, coverage | Bảng lương, phiếu lương | Payroll, payslip |
| Mã nhân viên | Employee ID | Phụ cấp | Allowance |
| Chức danh, quá trình công tác | Job title, job history | BHXH | Social insurance |
| Tiếp nhận, nghỉ việc | Hire, departure | Thuế TNCN | Personal income tax |
| Quy chế, câu hỏi thường gặp | Policy, FAQ | Người phụ thuộc | Dependant |
| Tín hiệu, điều đáng chú ý | Signal, insight | Lương tối thiểu vùng | Regional minimum wage |

## Accessibility

- **Target:** [ví dụ WCAG 2.2 mức AA]
- **Rules:** [ví dụ mọi input có label; không thể hiện trạng thái chỉ bằng màu; mọi thao tác làm được bằng bàn phím]
- **Checked by:** [công cụ tự động, thử bằng bàn phím, screen reader]

## Messages

Câu thông báo ghi chuyện gì xảy ra và người dùng nên làm gì. Lỗi có mã trong [api](api.md) thì mỗi mã có một câu.

| Situation | Message |
|---|---|
| *`booking_conflict` (BR-001)* | *Phòng đã có người đặt trong khung giờ này. Hãy chọn giờ khác.* |
