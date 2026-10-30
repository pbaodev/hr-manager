# Domain: hr-manager

- **Status:** Accepted
- **Updated:** 2026-10-30
- **Reviewed:** 2026-10-30: chủ dự án review từng phần qua PR #17 tới #22; agent chạy Analysis checklist. Chưa có
  người ngoài review
- **Related:** [requirements](requirements.md) · [questions](../project/questions.md) · [research](../project/research.md) ·
  [data design](../design/data.md) · [analysis guide](../playbook/analysis.md)

Bản hiện tại có đủ phần dùng chung và M1 tới M5.

## Glossary

Hệ thống có một bounded context.

| Term | Meaning | Code name | Not to confuse with |
|---|---|---|---|
| Nhân viên | Người có hồ sơ trong hệ thống, ở mọi trạng thái, kể cả đã nghỉ việc | `Employee` | Tài khoản |
| Tài khoản | Thông tin để một nhân viên đăng nhập | `UserAccount` | Nhân viên |
| Vai trò | Nhóm quyền trong hệ thống: Nhân viên, Quản lý, HR | `Role` | Chức danh |
| Chức danh | Tên công việc của nhân viên, ví dụ Kế toán viên | `Position` | Vai trò |
| Phòng ban | Một nút trong cây tổ chức, như khối, phòng hay nhóm | `OrgUnit` | — |
| Phòng ban gốc | Phòng ban ở đỉnh cây, đại diện cho cả công ty | `OrgUnit` có `parent` trống | — |
| Trưởng phòng ban | Nhân viên được bổ nhiệm phụ trách một phòng ban trong một khoảng thời gian | `HeadAssignment` | Quản lý trực tiếp |
| Quản lý trực tiếp | Người theo dõi và duyệt yêu cầu của một nhân viên, suy ra từ trưởng phòng ban theo BR-012 | `lineManager` | Trưởng phòng ban |
| Phạm vi quản lý | Tập nhân viên mà một Quản lý được xem, theo BR-013 | `managerScope` | — |
| Quá trình công tác | Một khoảng thời gian nhân viên thuộc một phòng ban với một chức danh | `Assignment` | Hợp đồng lao động |
| Ngày hiệu lực | Ngày một thay đổi bắt đầu có tác dụng; có thể trước hoặc sau ngày ghi nhận | `effectiveDate` | Ngày ghi nhận: ngày HR nhập thay đổi |
| Khoảng hiệu lực | Từ ngày tới ngày, tính cả hai đầu; ngày kết thúc trống nghĩa là chưa kết thúc | `DateRange` | — |
| Ngày vào làm | Ngày làm việc đầu tiên của nhân viên | `hireDate` | Ngày ký hợp đồng |
| Ngày làm việc cuối cùng | Ngày cuối cùng nhân viên làm việc; từ ngày hôm sau nhân viên ở trạng thái Đã nghỉ việc | `lastWorkingDate` | Ngày nộp đơn nghỉ việc |
| Khoảng làm việc | Từ ngày vào làm tới ngày làm việc cuối cùng, hoặc tới nay nếu chưa nghỉ. Người được tuyển lại có nhiều khoảng làm việc (BR-139) | `EmploymentPeriod` | Quá trình công tác |
| Hợp đồng lao động | Thỏa thuận lao động giữa công ty và nhân viên, gồm cả hợp đồng thử việc | `EmploymentContract` | Quá trình công tác |
| Nhật ký thao tác | Bản ghi không sửa được về mọi thay đổi dữ liệu | `AuditEntry` | — |
| Loại nghỉ | Một kiểu nghỉ có luật riêng, như phép năm, kết hôn, ốm đau | `LeaveType` | — |
| Đơn nghỉ | Yêu cầu nghỉ của một nhân viên cho một khoảng ngày, theo một loại nghỉ | `LeaveRequest` | — |
| Phép năm | Loại nghỉ có hưởng lương theo Điều 113 Bộ luật Lao động, trừ vào số dư phép | `ANNUAL` | Nghỉ việc riêng có lương: không trừ số dư |
| Phép năm cơ bản | Số ngày phép năm một nhân viên được hưởng cho cả năm, gồm cả ngày tăng theo thâm niên | `annualEntitlement` | Số dư phép |
| Số dư phép | Số ngày phép năm còn dùng được tại một ngày | `leaveBalance` | Phép năm cơ bản |
| Phép tồn | Phép năm chưa dùng được chuyển sang năm sau, có hạn dùng | `carryover` | — |
| Biến động phép | Một lần số dư phép thay đổi, kèm ngày, số ngày và lý do | `LeaveLedgerEntry` | — |
| Năm phép | Năm dương lịch dùng để tính phép năm | `leaveYear` | — |
| Ngày làm việc | Ngày nhân viên phải đi làm theo lịch làm việc của công ty | `workingDay` | Ngày dương lịch |
| Ngày làm bù | Ngày cuối tuần được đổi thành ngày làm việc, thường để bù cho kỳ nghỉ lễ dài | `makeupWorkday` | — |
| Buổi | Nửa ngày làm việc: sáng hoặc chiều | `HalfDay` | — |
| Người duyệt | Người được giao duyệt một đơn nghỉ, đơn làm thêm giờ hoặc giải trình chấm công | `approver` | Quản lý trực tiếp: người duyệt mặc định |
| Ca làm việc | Khung giờ làm việc lặp lại theo tuần, gồm giờ bắt đầu, giờ kết thúc, nghỉ giữa ca và các ngày làm việc trong tuần | `Shift` | — |
| Giờ làm chuẩn | Số giờ làm việc bình thường của một ca trong một ngày | `standardHours` | Giờ làm thực tế |
| Mã chấm công | Số định danh của nhân viên trên máy chấm công | `deviceUserId` | Mã nhân viên |
| Lượt chấm | Một lần nhân viên chấm trên máy, gồm mã chấm công và thời điểm | `PunchRecord` | — |
| Giờ vào, giờ ra | Lượt chấm sớm nhất và muộn nhất trong khoảng tính của một ngày ca | `checkIn`, `checkOut` | — |
| Công | Phần ngày làm việc được tính là đã làm: 1, 0,5 hoặc 0 | `workCredit` | Giờ làm thêm |
| Giải trình chấm công | Yêu cầu sửa giờ vào hoặc giờ ra của một ngày, kèm lý do, cần người duyệt | `AttendanceAdjustment` | — |
| Làm thêm giờ | Thời gian làm việc ngoài giờ làm chuẩn, đã được đăng ký và duyệt trước | `Overtime` | Ngồi lại muộn không đăng ký |
| Giờ làm ban đêm | Giờ làm trong khoảng từ `night_start` tới `night_end` | `nightHours` | — |
| Kỳ công | Một tháng dương lịch dùng để tổng hợp và chốt công | `AttendancePeriod` | — |
| Bảng công tháng | Tổng hợp công, nghỉ, đi muộn và làm thêm của một nhân viên trong một kỳ công | `MonthlyTimesheet` | — |
| Lương cơ bản | Mức lương tháng theo công việc hoặc chức danh, ghi trong hợp đồng, chưa gồm phụ cấp | `baseSalary` | Lương đóng bảo hiểm |
| Lương đóng bảo hiểm | Mức lương HR khai để tính BHXH, BHYT, BHTN | `insuranceSalary` | Lương cơ bản |
| Phụ cấp | Khoản trả thêm theo tháng ngoài lương cơ bản, như ăn giữa ca hay trách nhiệm | `Allowance` | Khoản điều chỉnh: chỉ áp cho một phiếu lương |
| Bản ghi lương | Lương cơ bản, lương đóng bảo hiểm và các phụ cấp của một nhân viên trong một khoảng hiệu lực | `SalaryRecord` | Hợp đồng lao động |
| Công chuẩn | Số ngày làm việc của cả tháng theo ca, dùng làm mẫu số khi tính lương (BR-103) | `standardWorkDays` | Số ngày làm việc chuẩn trong bảng công: chỉ đếm ngày trong khoảng làm việc (BR-092) |
| Công hưởng lương | Công cộng ngày nghỉ được công ty trả lương (BR-104) | `paidWorkDays` | Công |
| Đơn giá giờ | Tiền lương cho một giờ làm việc bình thường (BR-107) | `hourlyRate` | — |
| Lương tối thiểu vùng | Mức lương tháng thấp nhất theo vùng do Chính phủ quy định | `regionalMinWage` | Mức tham chiếu |
| Mức tham chiếu | Mức tiền dùng để tính trần đóng BHXH, BHYT theo Luật Bảo hiểm xã hội 2024 | `referenceWage` | Lương tối thiểu vùng |
| Người phụ thuộc | Người được nhân viên khai để giảm trừ gia cảnh khi tính thuế | `Dependent` | Người liên hệ khẩn cấp |
| Thu nhập chịu thuế | Phần thu nhập từ tiền lương, tiền công phải tính thuế, sau khi bỏ phần được miễn (BR-111) | `taxableIncome` | Thu nhập tính thuế |
| Thu nhập tính thuế | Thu nhập chịu thuế trừ bảo hiểm nhân viên đóng và giảm trừ gia cảnh; là cơ sở áp biểu thuế (BR-112) | `assessableIncome` | Thu nhập chịu thuế |
| Cam kết thu nhập | Văn bản nhân viên không có hợp đồng từ 3 tháng cam kết tổng thu nhập năm chưa tới mức phải nộp thuế | `incomeCommitment` | — |
| Tham số lương | Giá trị luật định dùng khi tính lương, như tỷ lệ bảo hiểm hay biểu thuế, có ngày hiệu lực | `PayrollParameter` | Tham số khác trong mục Parameters: một giá trị cấu hình, không có ngày hiệu lực |
| Bảng lương | Tập phiếu lương của mọi nhân viên trong một tháng | `PayrollRun` | Bảng công tháng |
| Phiếu lương | Kết quả tính lương của một nhân viên trong một tháng, gồm từng dòng thu nhập và khấu trừ | `Payslip` | — |
| Khoản điều chỉnh | Dòng HR thêm tay vào một phiếu lương, như thưởng, tạm ứng, truy lĩnh hay truy thu | `PayAdjustment` | Phụ cấp |
| Thực lĩnh | Số tiền nhân viên nhận sau mọi khoản khấu trừ (BR-114) | `netPay` | Tổng thu nhập |
| Chi phí lương | Số tiền công ty bỏ ra cho một nhân viên trong một tháng: tổng thu nhập cộng phần công ty đóng (BR-131) | `laborCost` | Thực lĩnh; tổng thu nhập |
| Biến động nhân sự | Số người đầu kỳ, vào mới, nghỉ việc, chuyển đến, chuyển đi và cuối kỳ trong một kỳ báo cáo (BR-132) | `headcountMovement` | — |
| Tỷ lệ nghỉ việc | Số người nghỉ việc trong kỳ chia số người bình quân của kỳ (BR-132) | `turnoverRate` | — |
| Kỳ báo cáo | Khoảng tháng hoặc khoảng ngày người xem chọn cho một báo cáo | `reportPeriod` | Kỳ công, kỳ lương |

## Entities

```mermaid
classDiagram
  Employee "1" --> "1..*" Assignment : có
  Assignment "*" --> "1" OrgUnit : thuộc
  Assignment "*" --> "1" Position : giữ
  OrgUnit "1" *-- "1..*" OrgUnitPeriod : lịch sử
  OrgUnitPeriod "*" --> "0..1" OrgUnit : phòng ban cha
  HeadAssignment "*" --> "1" OrgUnit : phụ trách
  HeadAssignment "*" --> "1" Employee : người được bổ nhiệm
  Employee "1" --> "*" EmploymentContract : ký
  Employee "1" --> "0..1" UserAccount : đăng nhập bằng
```

| Name | Kind | Key attributes | Relations |
|---|---|---|---|
| Employee | Entity | Mã nhân viên, họ tên, ngày sinh, giới tính, số CCCD, địa chỉ thường trú, địa chỉ hiện tại, điện thoại và email cá nhân, điện thoại và email công việc, tài khoản ngân hàng, người liên hệ khẩn cấp, trạng thái | Có nhiều EmploymentPeriod, Assignment và EmploymentContract; có tối đa một UserAccount |
| EmploymentPeriod | Value object | Ngày vào làm, ngày làm việc cuối cùng, lý do nghỉ | Thuộc một Employee; các khoảng không chồng nhau |
| Assignment | Entity | Khoảng hiệu lực, phòng ban, chức danh, lý do | Thuộc một Employee |
| OrgUnit | Entity | Mã phòng ban, ngày thành lập, ngày giải thể, trạng thái | Có lịch sử OrgUnitPeriod và nhiều HeadAssignment |
| OrgUnitPeriod | Value object | Khoảng hiệu lực, tên, phòng ban cha | Thuộc một OrgUnit |
| HeadAssignment | Entity | Khoảng hiệu lực, phòng ban, người được bổ nhiệm | — |
| Position | Entity | Tên, đang dùng hay ngừng dùng | Được nhiều Assignment dùng |
| EmploymentContract | Entity | Số hợp đồng, loại, nhóm công việc khi thử việc, ngày ký, ngày bắt đầu, ngày kết thúc, trạng thái | Thuộc một Employee |
| UserAccount | Entity | Tên đăng nhập, có vai trò HR hay không, có phải đổi mật khẩu không, số lần đăng nhập sai liên tiếp, trạng thái | Thuộc một Employee |
| AuditEntry | Entity | Thời điểm, người làm, đối tượng, thao tác, giá trị trước và sau, lý do | — |
| DateRange | Value object | Ngày bắt đầu, ngày kết thúc có thể trống; ngày kết thúc không trước ngày bắt đầu | — |

**M2: nghỉ phép**

```mermaid
classDiagram
  Employee "1" --> "*" LeaveRequest : gửi
  LeaveRequest "*" --> "1" LeaveType : thuộc loại
  LeaveRequest "*" --> "0..1" Employee : người duyệt
  Employee "1" --> "*" LeaveLedgerEntry : biến động phép
  LeaveLedgerEntry "*" --> "0..1" LeaveRequest : phát sinh từ
  WorkCalendar "1" *-- "*" CalendarDay : ngày lễ, ngày làm bù
```

| Name | Kind | Key attributes | Relations |
|---|---|---|---|
| Employee | Entity, bổ sung ở M2 | Phép năm cơ bản không tính thâm niên: 12, 14 hoặc 16 ngày | — |
| LeaveType | Entity | Tên, chế độ hưởng (công ty trả lương, BHXH chi trả, không hưởng lương), có trừ phép năm không, số ngày tối đa mỗi đơn, đang dùng hay ngừng | Có nhiều LeaveRequest |
| LeaveRequest | Entity | Loại nghỉ, ngày và buổi bắt đầu, ngày và buổi kết thúc, số ngày, lý do, người duyệt, người ghi nếu HR ghi thay, trạng thái, lý do từ chối hoặc hủy | Thuộc một Employee |
| LeaveLedgerEntry | Entity | Ngày, loại biến động, số ngày có dấu, năm phép, là phép tồn hay không, hạn dùng nếu là phép tồn, lý do | Thuộc một Employee; có thể phát sinh từ một LeaveRequest |
| WorkCalendar | Entity | Ngày nghỉ lễ và ngày làm bù của công ty; ngày làm việc trong tuần thuộc về ca từ M3 | Một lịch cho cả công ty; chứa nhiều CalendarDay |
| CalendarDay | Value object | Ngày, loại (nghỉ lễ hoặc làm bù), tên | Thuộc WorkCalendar |

**M3: chấm công**

```mermaid
classDiagram
  Employee "1" --> "1..*" ShiftAssignment : có
  ShiftAssignment "*" --> "1" Shift : dùng
  PunchImport "1" --> "*" PunchRecord : tạo
  PunchRecord "*" --> "0..1" Employee : ghép theo mã chấm công
  Employee "1" --> "*" AttendanceDay : có
  Employee "1" --> "*" AttendanceAdjustment : gửi
  Employee "1" --> "*" OvertimeRequest : gửi
  AttendancePeriod "1" --> "*" MonthlyTimesheet : chụp khi chốt
  Employee "1" --> "*" MonthlyTimesheet : có
```

| Name | Kind | Key attributes | Relations |
|---|---|---|---|
| Employee | Entity, bổ sung ở M3 | Mã chấm công | — |
| Shift | Entity | Tên, giờ bắt đầu, giờ kết thúc, khoảng nghỉ giữa ca, nghỉ giữa ca có tính vào giờ làm không, các ngày làm việc trong tuần, đang dùng hay ngừng | Có nhiều ShiftAssignment |
| ShiftAssignment | Entity | Khoảng hiệu lực, ca | Thuộc một Employee |
| PunchImport | Entity | Tên file, người nhập, thời điểm, số dòng đã lưu, số dòng trùng, các dòng bị bỏ qua kèm lý do | Tạo nhiều PunchRecord |
| PunchRecord | Entity | Mã chấm công, thời điểm | Thuộc một PunchImport; ghép với Employee theo mã chấm công |
| AttendanceDay | Entity | Ngày, ca, giờ vào, giờ ra, phút đi muộn, phút về sớm, công, loại nghỉ nếu có, giờ làm thêm theo loại, giờ làm ban đêm, trạng thái, đánh dấu cần xem | Thuộc một Employee; được tính từ lượt chấm, đơn nghỉ, đơn làm thêm và giải trình |
| AttendanceAdjustment | Entity | Ngày, giờ vào đề nghị, giờ ra đề nghị, lý do, người duyệt, trạng thái | Thuộc một Employee |
| OvertimeRequest | Entity | Ngày, giờ bắt đầu, giờ kết thúc, lý do, người duyệt, trạng thái | Thuộc một Employee |
| AttendancePeriod | Entity | Tháng, trạng thái, người chốt, thời điểm chốt, lý do mở lại | Một kỳ công cho cả công ty |
| MonthlyTimesheet | Entity | Các số tổng hợp theo BR-092 | Thuộc một Employee và một AttendancePeriod |

Trạng thái của AttendanceDay được tính lại mỗi khi dữ liệu nguồn đổi, nên không có vòng đời riêng: Chưa tới, Ngày nghỉ,
Đủ công, Nghỉ theo đơn, Nửa công nửa nghỉ, Thiếu chấm công, Vắng chưa xử lý, Vắng không lý do.

**M4: lương và phúc lợi**

```mermaid
classDiagram
  Employee "1" --> "*" SalaryRecord : có
  SalaryRecord "1" --> "*" SalaryAllowance : gồm
  SalaryAllowance "*" --> "1" AllowanceType : thuộc loại
  Employee "1" --> "*" Dependent : khai
  PayrollRun "1" --> "*" Payslip : gồm
  Payslip "*" --> "1" Employee : của
  Payslip "1" --> "*" PayslipLine : gồm
  PayrollRun "1" --> "1" AttendancePeriod : tính từ
  PayrollParameter "*" ..> PayrollRun : dùng khi tính
```

| Name | Kind | Key attributes | Relations |
|---|---|---|---|
| Employee | Entity, bổ sung ở M4 | Mã số thuế, mã số BHXH, năm có cam kết thu nhập | — |
| AllowanceType | Entity | Tên, cách tính (theo công hoặc cố định theo tháng), chế độ thuế (chịu thuế, miễn thuế, miễn thuế trong mức), mức miễn thuế, đang dùng hay ngừng | Có nhiều SalaryAllowance |
| SalaryRecord | Entity | Khoảng hiệu lực, lương cơ bản, lương đóng bảo hiểm, lý do | Thuộc một Employee; gồm nhiều SalaryAllowance |
| SalaryAllowance | Value object | Loại phụ cấp, số tiền mỗi tháng | Thuộc một SalaryRecord |
| Dependent | Entity | Họ tên, quan hệ, ngày sinh, số định danh hoặc mã số thuế, tháng bắt đầu, tháng kết thúc | Thuộc một Employee |
| PayrollParameter | Entity | Tên tham số, giá trị, ngày hiệu lực. Biểu thuế là danh sách bậc, mỗi bậc có cận dưới, cận trên và thuế suất | Một tham số có nhiều giá trị theo ngày hiệu lực |
| PayrollRun | Entity | Tháng, trạng thái, người và thời điểm tính gần nhất, người và thời điểm chốt | Một bảng lương mỗi tháng cho cả công ty; gồm nhiều Payslip |
| Payslip | Entity | Công chuẩn, công hưởng lương, số người phụ thuộc, giá trị tham số đã dùng, tổng thu nhập, thu nhập chịu thuế, thu nhập tính thuế, thuế, thực lĩnh, phần công ty đóng, lỗi và cảnh báo | Thuộc một PayrollRun và một Employee; gồm nhiều PayslipLine |
| PayslipLine | Entity | Nhóm (thu nhập, khấu trừ, công ty đóng), tên, số tiền, phần chịu thuế, nguồn (hệ thống tính hoặc HR thêm), lý do nếu HR thêm | Thuộc một Payslip |

Phiếu lương lưu lại mọi số liệu đầu vào đã dùng, để đọc phiếu cũ không phải tính lại từ dữ liệu hiện tại.

**M5: báo cáo**

M5 không thêm entity. Báo cáo đọc từ entity của M1 tới M4 (BR-138); việc xuất báo cáo được ghi bằng AuditEntry.

## Aggregates and invariants

| Aggregate (root) | Contains | Invariants | Cross-aggregate rules |
|---|---|---|---|
| Employee | Employee, EmploymentPeriod, Assignment | Mã nhân viên không đổi (BR-015); khoảng làm việc không chồng (BR-139); quá trình công tác không chồng, không hở trong mỗi khoảng làm việc (BR-016) | Phòng ban của mỗi quá trình công tác phải đang hoạt động (BR-014); số CCCD không trùng (BR-022) |
| EmploymentContract | EmploymentContract | Thời hạn hợp lệ theo loại hợp đồng (BR-024, BR-028) | Hợp đồng của một nhân viên không chồng thời gian (BR-025); kiểm số hợp đồng xác định thời hạn liên tiếp (BR-026); số hợp đồng không trùng (BR-037) |
| OrgUnit | OrgUnit, OrgUnitPeriod | Các khoảng lịch sử không chồng; tên không trống | Đúng một phòng ban gốc (BR-007); cây không có vòng (BR-008); điều kiện giải thể (BR-010) |
| HeadAssignment | HeadAssignment | Khoảng hiệu lực hợp lệ | Mỗi phòng ban có tối đa một trưởng mỗi ngày; người được bổ nhiệm đang làm việc (BR-011) |
| UserAccount | UserAccount | BR-001, BR-002, BR-003 | Luôn còn ít nhất một HR đang hoạt động (BR-004) |
| LeaveRequest | LeaveRequest | Số ngày khớp lịch làm việc (BR-044); không vượt tối đa của loại nghỉ (BR-047) | Không chồng buổi với đơn khác (BR-045); nằm trong khoảng làm việc (BR-046); hai đơn phép năm gửi hoặc duyệt cùng lúc không được làm thiếu phép (BR-053, EC-024) |
| LeaveLedgerEntry | LeaveLedgerEntry | Không sửa, không xóa (BR-054) | Số dư phép bằng tổng các biến động (BR-054); mỗi tháng chỉ được cộng một lần (EC-038) |
| LeaveType | LeaveType | BR-040 | Có đúng một loại Phép năm (BR-041) |
| WorkCalendar | WorkCalendar, CalendarDay | Một ngày không vừa là ngày nghỉ lễ vừa là ngày làm bù | Đổi lịch thì tính lại các đơn chưa bắt đầu (BR-064); không đổi lịch trong tháng đã chốt (BR-090) |
| Shift | Shift | Giờ làm chuẩn và hai buổi tính được (BR-068, BR-069) | — |
| Employee (M3) | ShiftAssignment | Mỗi ngày từ ngày vào làm có đúng một ca (BR-070) | Mã chấm công không trùng giữa nhân viên đang làm (BR-072) |
| PunchImport | PunchImport, PunchRecord | Lượt chấm không trùng (BR-073) | Không nhập vào tháng đã chốt (BR-090) |
| OvertimeRequest | OvertimeRequest | Nằm ngoài giờ ca; gửi trước giờ bắt đầu (BR-083, BR-086) | Giới hạn giờ làm thêm theo ngày, tháng, năm, tính cả đơn khác (BR-084) |
| AttendancePeriod | AttendancePeriod, MonthlyTimesheet | Bảng công đã chụp không đổi khi kỳ đã chốt | Điều kiện chốt (BR-089); mở lại chỉ khi bảng lương chưa chốt (BR-091) |
| AllowanceType | AllowanceType | Tên không trùng (BR-097) | — |
| SalaryRecord | SalaryRecord, SalaryAllowance | Mỗi loại phụ cấp tối đa một lần trong một bản ghi | Các bản ghi của một nhân viên không chồng, không hở (BR-093); mức sàn theo lương tối thiểu vùng tại ngày hiệu lực (BR-094, BR-096) |
| Dependent | Dependent | Tháng kết thúc không trước tháng bắt đầu | Một người phụ thuộc không được tính cho hai nhân viên trong cùng tháng (BR-099) |
| PayrollParameter | PayrollParameter | Biểu thuế có các bậc liền nhau, bậc đầu từ 0, bậc cuối không có cận trên | Mỗi tham số không có hai giá trị cùng ngày hiệu lực; giá trị đã dùng ở bảng lương đã chốt không sửa được (BR-123) |
| PayrollRun | PayrollRun, Payslip, PayslipLine | Thực lĩnh của phiếu bằng tổng các dòng (BR-114); không đổi khi đã chốt (BR-118) | Chỉ tính khi bảng công đã chốt (BR-102); điều kiện chốt (BR-117); hai thao tác chốt cùng lúc chỉ một thành công (EC-072) |

## Lifecycles

Chuyển trạng thái không có trong bảng là không được phép. Chuyển trạng thái do "Thời gian" xảy ra khi tới ngày tương
ứng, không cần ai thao tác.

**Employee**

```mermaid
stateDiagram-v2
  state "Sắp vào làm" as upcoming
  state "Đang làm" as active
  state "Đã nghỉ việc" as terminated
  state "Đã hủy tiếp nhận" as cancelled
  [*] --> upcoming: tiếp nhận, ngày vào làm ở tương lai
  [*] --> active: tiếp nhận, ngày vào làm từ hôm nay trở về trước
  upcoming --> active: tới ngày vào làm
  upcoming --> cancelled: HR hủy tiếp nhận
  active --> terminated: qua ngày làm việc cuối cùng
  terminated --> upcoming: HR tuyển lại
  terminated --> anonymized: HR ẩn danh khi hết hạn lưu
  state "Đã ẩn danh" as anonymized
  anonymized --> [*]
  cancelled --> [*]
```

| From | To | Trigger and actor | Guard |
|---|---|---|---|
| — | `upcoming` | HR tiếp nhận | Ngày vào làm sau hôm nay |
| — | `active` | HR tiếp nhận hoặc nhập từ bảng tính | Ngày vào làm từ hôm nay trở về trước |
| `upcoming` | `active` | Thời gian, tới ngày vào làm | — |
| `upcoming` | `cancelled` | HR hủy tiếp nhận | Trước ngày vào làm |
| `active` | `terminated` | Thời gian, sang ngày sau ngày làm việc cuối cùng | HR đã ghi nhận nghỉ việc (BR-019) |
| `terminated` | `upcoming` | HR tuyển lại; tới ngày vào làm mới thì sang `active` như trên | Ngày vào làm mới sau ngày làm việc cuối cùng của khoảng trước (BR-139) |
| `terminated` | `anonymized` | HR xác nhận ẩn danh | Đã quá `retention_years` năm từ ngày làm việc cuối cùng (BR-141) |

**UserAccount**

```mermaid
stateDiagram-v2
  state "Hoạt động" as active
  state "Khóa tạm" as throttled
  state "Bị khóa" as locked
  [*] --> active: HR tạo
  active --> throttled: nhập sai mật khẩu nhiều lần
  throttled --> active: hết thời gian khóa tạm, hoặc HR mở khóa
  active --> locked: HR khóa, hoặc nhân viên nghỉ việc
  throttled --> locked: HR khóa, hoặc nhân viên nghỉ việc
  locked --> active: HR mở khóa
```

| From | To | Trigger and actor | Guard |
|---|---|---|---|
| — | `active` | HR tạo tài khoản | Nhân viên chưa có tài khoản (BR-001) |
| `active` | `throttled` | Người dùng nhập sai mật khẩu `max_failed_logins` lần liên tiếp | — (BR-003) |
| `throttled` | `active` | Thời gian, sau `lockout_minutes` phút; hoặc HR mở khóa | — |
| `active`, `throttled` | `locked` | HR khóa; hoặc Thời gian, khi nhân viên nghỉ việc | Không phải HR đang hoạt động cuối cùng (BR-004) |
| `locked` | `active` | HR mở khóa | Nhân viên chưa nghỉ việc (BR-005) |

**OrgUnit**

```mermaid
stateDiagram-v2
  state "Sắp thành lập" as planned
  state "Đang hoạt động" as active
  state "Đã giải thể" as dissolved
  [*] --> planned: tạo, ngày thành lập ở tương lai
  [*] --> active: tạo, ngày thành lập từ hôm nay trở về trước
  planned --> active: tới ngày thành lập
  active --> dissolved: tới ngày giải thể
  dissolved --> [*]
```

| From | To | Trigger and actor | Guard |
|---|---|---|---|
| — | `planned`, `active` | HR tạo phòng ban | Phòng ban cha đang hoạt động tại ngày thành lập |
| `planned` | `active` | Thời gian, tới ngày thành lập | — |
| `active` | `dissolved` | Thời gian, tới ngày giải thể do HR đặt | BR-007, BR-010 |

**EmploymentContract**

```mermaid
stateDiagram-v2
  state "Chưa hiệu lực" as upcoming
  state "Đang hiệu lực" as active
  state "Hết hạn" as expired
  state "Đã chấm dứt" as terminated
  [*] --> upcoming: HR thêm, ngày bắt đầu ở tương lai
  [*] --> active: HR thêm, ngày bắt đầu từ hôm nay trở về trước
  upcoming --> active: tới ngày bắt đầu
  active --> expired: qua ngày kết thúc
  active --> terminated: nhân viên nghỉ việc trước ngày kết thúc
  expired --> [*]
  terminated --> [*]
```

| From | To | Trigger and actor | Guard |
|---|---|---|---|
| — | `upcoming`, `active` | HR thêm hợp đồng | BR-023 tới BR-028 |
| `upcoming` | `active` | Thời gian, tới ngày bắt đầu | — |
| `active` | `expired` | Thời gian, qua ngày kết thúc | Hợp đồng có ngày kết thúc |
| `active` | `terminated` | HR ghi nhận nghỉ việc | Ngày làm việc cuối cùng trước ngày kết thúc của hợp đồng (BR-019) |

**LeaveRequest**

```mermaid
stateDiagram-v2
  state "Chờ duyệt" as pending
  state "Đã duyệt" as approved
  state "Bị từ chối" as rejected
  state "Đã hủy" as cancelled
  [*] --> pending: nhân viên gửi
  [*] --> approved: HR ghi đơn thay
  pending --> approved: người duyệt hoặc HR duyệt
  pending --> rejected: người duyệt hoặc HR từ chối
  pending --> cancelled: nhân viên hủy, hoặc nhân viên nghỉ việc
  approved --> cancelled: nhân viên hoặc HR hủy, hoặc nhân viên nghỉ việc
  approved --> [*]
  rejected --> [*]
  cancelled --> [*]
```

| From | To | Trigger and actor | Guard |
|---|---|---|---|
| — | `pending` | Nhân viên gửi đơn | BR-043 tới BR-047, BR-053, BR-062 |
| — | `approved` | HR ghi đơn thay | Như trên, trừ giới hạn ghi bù (BR-062, BR-063) |
| `pending` | `approved` | Người duyệt hoặc HR duyệt | Người duyệt không phải người gửi (BR-060); vẫn đủ phép (BR-053) |
| `pending` | `rejected` | Người duyệt hoặc HR từ chối | Có lý do (BR-059) |
| `pending` | `cancelled` | Nhân viên hủy; hoặc Thời gian, khi việc nghỉ việc có hiệu lực | — |
| `approved` | `cancelled` | Nhân viên hủy; HR hủy; hoặc Thời gian, khi việc nghỉ việc có hiệu lực | Nhân viên chỉ hủy được trước ngày bắt đầu; HR phải nhập lý do (BR-061, BR-065) |
| `approved` | `approved` | HR rút ngắn đơn đã bắt đầu | Có lý do; phép năm được hoàn phần rút ngắn (BR-061) |

Mọi chuyển trạng thái của LeaveRequest bị chặn khi đơn có ngày thuộc tháng đã chốt (BR-090).

**OvertimeRequest và AttendanceAdjustment**

Hai loại đơn này dùng chung vòng đời và luật duyệt của đơn nghỉ (BR-056 tới BR-059), không có HR ghi thay.

```mermaid
stateDiagram-v2
  state "Chờ duyệt" as pending
  state "Đã duyệt" as approved
  state "Bị từ chối" as rejected
  state "Đã hủy" as cancelled
  [*] --> pending: nhân viên gửi
  pending --> approved: người duyệt hoặc HR duyệt
  pending --> rejected: người duyệt hoặc HR từ chối
  pending --> cancelled: nhân viên hủy
  approved --> cancelled: nhân viên hủy đơn làm thêm trước giờ bắt đầu, hoặc HR hủy
  approved --> [*]
  rejected --> [*]
  cancelled --> [*]
```

| From | To | Trigger and actor | Guard |
|---|---|---|---|
| — | `pending` | Nhân viên gửi | Đơn làm thêm: BR-083, BR-084, BR-086, BR-087. Giải trình: BR-081. Tháng chưa chốt (BR-090) |
| `pending` | `approved` | Người duyệt hoặc HR duyệt | Người duyệt không phải người gửi (BR-060); đơn làm thêm vẫn trong giới hạn (BR-084) |
| `pending` | `rejected` | Người duyệt hoặc HR từ chối | Có lý do (BR-059) |
| `pending` | `cancelled` | Nhân viên hủy | Tháng chưa chốt |
| `approved` | `cancelled` | Nhân viên hủy đơn làm thêm trước giờ bắt đầu; HR hủy kèm lý do | Tháng chưa chốt |

**AttendancePeriod**

```mermaid
stateDiagram-v2
  state "Đang mở" as open
  state "Đã chốt" as closed
  [*] --> open: tháng bắt đầu
  open --> closed: HR chốt
  closed --> open: HR mở lại
```

| From | To | Trigger and actor | Guard |
|---|---|---|---|
| — | `open` | Thời gian, ngày đầu tháng | — |
| `open` | `closed` | HR chốt | Không còn việc chặn theo BR-089 |
| `closed` | `open` | HR mở lại | Có lý do; bảng lương của tháng chưa chốt (BR-091) |

**PayrollRun**

```mermaid
stateDiagram-v2
  state "Nháp" as draft
  state "Cần tính lại" as stale
  state "Đã chốt" as closed
  [*] --> draft: HR tính lương
  draft --> draft: HR tính lại hoặc sửa khoản điều chỉnh
  draft --> stale: dữ liệu nguồn đổi
  stale --> draft: HR tính lại
  draft --> closed: HR chốt
  closed --> [*]
```

| From | To | Trigger and actor | Guard |
|---|---|---|---|
| — | `draft` | HR tính lương | Bảng công của tháng đã chốt (BR-102) |
| `draft` | `draft` | HR tính lại; HR thêm, sửa hoặc xóa khoản điều chỉnh | — (BR-115, BR-116) |
| `draft` | `stale` | Hệ thống, khi dữ liệu nguồn của tháng đổi | BR-119 |
| `stale` | `draft` | HR tính lại | Bảng công của tháng đã chốt (BR-102) |
| `draft` | `closed` | HR chốt | BR-117 |

Bảng lương đã chốt không có chuyển trạng thái nào (BR-118).

## Business rules

- **Status:** `Confirmed` khi có nguồn xác nhận; `Assumed` khi dựa trên assumption; `Disputed` khi các nguồn mâu thuẫn và
  chưa ai chốt. Luật `Disputed` không được đưa vào code.
- **Nguồn A-003:** luật do agent đề xuất theo cách làm phổ biến ở doanh nghiệp nhỏ, chưa được HR công ty xác nhận.
- **Nguồn là văn bản pháp luật:** luật giữ `Assumed` cho tới khi đối chiếu văn bản gốc (A-013).

**Tài khoản và vai trò**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-001 | Tạo tài khoản cho một nhân viên | Mỗi nhân viên có tối đa một tài khoản; tên đăng nhập là mã nhân viên | A-003, A-004 | Assumed |
| BR-002 | Tài khoản vừa được tạo hoặc vừa được HR đặt lại mật khẩu | Người dùng phải đặt mật khẩu mới ở lần đăng nhập kế tiếp, trước khi dùng chức năng khác | A-003 | Assumed |
| BR-003 | Nhập sai mật khẩu `max_failed_logins` lần liên tiếp | Tài khoản bị khóa tạm `lockout_minutes` phút | A-003 | Assumed |
| BR-004 | Thu hồi vai trò HR, khóa tài khoản hoặc ghi nhận nghỉ việc của HR đang hoạt động cuối cùng | Từ chối | A-003 | Assumed |
| BR-005 | Nhân viên qua ngày làm việc cuối cùng | Tài khoản tự bị khóa và không mở khóa được nữa, trừ khi nhân viên được tuyển lại (BR-139) | A-003 | Assumed |
| BR-006 | Xác định vai trò của một người tại ngày D | Nhân viên: có tài khoản đang hoạt động. Quản lý: đang là trưởng của ít nhất một phòng ban tại D; không gán tay. HR: được gán tay | Chủ dự án, 2026-10-30 | Confirmed |
| BR-036 | Đặt mật khẩu mới | Mật khẩu dài tối thiểu `min_password_length` ký tự và khác mật khẩu hiện tại | A-003 | Assumed |

**Cơ cấu tổ chức**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-007 | Tạo hoặc sửa cơ cấu tổ chức | Cơ cấu là một cây nhiều cấp có đúng một phòng ban gốc. Phòng ban gốc không có phòng ban cha, không bị chuyển, không bị giải thể; chỉ đổi tên được | Chủ dự án, 2026-10-30 | Confirmed |
| BR-008 | Đổi phòng ban cha của P thành Q từ ngày D | Từ chối nếu tại D, Q là P hoặc Q nằm trong nhánh con của P | Hệ quả của BR-007 | Confirmed |
| BR-009 | Đổi tên hoặc phòng ban cha của một phòng ban với ngày hiệu lực D | Thay đổi có tác dụng từ D; cơ cấu tại một ngày bất kỳ dùng giá trị có hiệu lực tại ngày đó | Chủ dự án, mục tiêu học trong [project](../project/project.md) | Confirmed |
| BR-010 | Giải thể phòng ban P từ ngày D | Từ chối nếu từ D trở đi còn nhân viên thuộc P, kể cả do thay đổi công tác đã ghi cho tương lai, hoặc còn phòng ban con của P đang hoạt động | A-003 | Assumed |
| BR-011 | Bổ nhiệm trưởng cho phòng ban P trong một khoảng hiệu lực | Mỗi ngày P có tối đa một trưởng. Người được bổ nhiệm phải đang làm việc trong suốt khoảng đó. Một người được làm trưởng nhiều phòng ban; trưởng không bắt buộc thuộc P | A-003 | Assumed |
| BR-012 | Xác định quản lý trực tiếp của nhân viên X tại ngày D | Lấy trưởng của phòng ban X thuộc tại D. Nếu phòng ban đó không có trưởng, hoặc trưởng chính là X, thì đi lên phòng ban cha gần nhất có trưởng khác X. Không tìm được ai thì X không có quản lý trực tiếp | Chủ dự án, 2026-10-30 | Confirmed |
| BR-013 | Xác định phạm vi của Quản lý M tại ngày D | Gồm mọi nhân viên thuộc các phòng ban M làm trưởng tại D và mọi phòng ban con của chúng | Chủ dự án, 2026-10-30 | Confirmed |
| BR-014 | Xếp nhân viên vào một phòng ban | Phòng ban phải đang hoạt động trong mọi ngày của quá trình công tác | A-003 | Assumed |
| BR-034 | Thêm hoặc đổi tên chức danh | Tên chức danh không trùng, không phân biệt hoa thường | A-003 | Assumed |
| BR-035 | Xóa chức danh đã được dùng trong quá trình công tác | Từ chối; chỉ ngừng dùng được. Chức danh ngừng dùng không chọn được cho thay đổi mới | A-003 | Assumed |

**Hồ sơ và công tác**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-015 | Cấp mã nhân viên | Mã duy nhất trong toàn hệ thống, không đổi, không dùng lại kể cả sau khi nhân viên nghỉ việc. Hệ thống tự cấp theo `employee_code_format` khi tiếp nhận; khi nhập từ bảng tính thì giữ mã trong file | A-003 | Assumed |
| BR-016 | Lưu quá trình công tác của một nhân viên | Trong mỗi khoảng làm việc, mỗi ngày nhân viên có đúng một quá trình công tác; các quá trình không chồng, không hở. Ngoài khoảng làm việc thì không có quá trình công tác | A-003 | Assumed |
| BR-017 | Ghi nhận thay đổi công tác với ngày hiệu lực D | D phải nằm trong khoảng làm việc. Quá trình chứa D kết thúc ở D−1. Quá trình mới bắt đầu từ D và kéo dài tới ngày trước thay đổi kế tiếp đã có, hoặc tới ngày làm việc cuối cùng | A-003 | Assumed |
| BR-018 | Ghi nhận thay đổi công tác với ngày hiệu lực trước hôm nay | Lý do là bắt buộc | A-003 | Assumed |
| BR-019 | Ghi nhận nghỉ việc với ngày làm việc cuối cùng L | Quá trình công tác, bổ nhiệm trưởng và hợp đồng đang hiệu lực kết thúc ở L. Từ ngày sau L, nhân viên ở trạng thái Đã nghỉ việc và tài khoản bị khóa | A-003 | Assumed |
| BR-020 | Hủy ghi nhận nghỉ việc | Chỉ được khi L chưa qua | A-003 | Assumed |
| BR-021 | Nhân viên tự sửa hồ sơ của mình | Chỉ sửa được điện thoại cá nhân, email cá nhân, địa chỉ hiện tại và người liên hệ khẩn cấp; thay đổi có hiệu lực ngay. Thông tin còn lại chỉ HR sửa | A-003 | Assumed |
| BR-022 | Lưu số CCCD | Số CCCD không trùng giữa các hồ sơ chưa bị hủy tiếp nhận | A-003 | Assumed |
| BR-139 | HR tuyển lại nhân viên ở trạng thái Đã nghỉ việc | Dùng lại hồ sơ và mã nhân viên cũ, thêm một khoảng làm việc mới với ngày vào làm sau ngày làm việc cuối cùng của khoảng trước. Quá trình công tác, hợp đồng, ca và bản ghi lương được nhập mới cho khoảng đó. Tài khoản cũ được mở khóa lại. Phép năm bắt đầu từ 0 vì phép chưa nghỉ đã được trả khi nghỉ việc (BR-120); thâm niên ở BR-048 chỉ tính từ ngày vào làm mới | Chủ dự án, 2026-10-30 | Confirmed |
| BR-140 | Nhân viên đã nghỉ việc quá `contact_retention_months` tháng | Hệ thống đưa người đó vào danh sách cần xóa thông tin liên hệ. HR xác nhận thì xóa điện thoại, email, địa chỉ cá nhân, người liên hệ khẩn cấp và tài khoản ngân hàng. Hệ thống không tự xóa khi chưa có xác nhận. Nhật ký ghi việc xóa nhưng không chép lại giá trị đã xóa | Chủ dự án, 2026-10-30; Luật Bảo vệ dữ liệu cá nhân 2025 | Confirmed |
| BR-141 | Nhân viên đã nghỉ việc quá `retention_years` năm | Hệ thống đưa người đó vào danh sách cần ẩn danh. HR xác nhận thì xóa mọi thông tin cá nhân, người phụ thuộc, lý do nghỉ và nội dung các đơn; hồ sơ chỉ còn mã nhân viên. Số liệu đã chốt trong bảng công, bảng lương và báo cáo tổng hợp được giữ | Chủ dự án, 2026-10-30; Luật Kế toán về thời hạn lưu tài liệu kế toán | Assumed |

**Hợp đồng lao động**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-023 | Chọn loại hợp đồng | Có ba loại: thử việc, xác định thời hạn, không xác định thời hạn | Bộ luật Lao động 2019, Điều 20 và Điều 24 | Assumed |
| BR-024 | Lưu hợp đồng xác định thời hạn | Phải có ngày kết thúc, không quá `fixed_term_max_months` tháng sau ngày bắt đầu; vi phạm thì từ chối | Bộ luật Lao động 2019, Điều 20 | Assumed |
| BR-025 | Lưu một hợp đồng | Các hợp đồng của một nhân viên, kể cả thử việc, không chồng thời gian | A-003 | Assumed |
| BR-026 | Thêm hợp đồng xác định thời hạn khi hai hợp đồng liền trước đều là xác định thời hạn | Cảnh báo rằng luật yêu cầu ký hợp đồng không xác định thời hạn; HR xác nhận thì vẫn lưu, vì luật có ngoại lệ | Bộ luật Lao động 2019, Điều 20 | Assumed |
| BR-027 | Hợp đồng xác định thời hạn đã hết hạn, nhân viên vẫn làm việc và chưa có hợp đồng mới | Cảnh báo HR. Sau `contract_auto_convert_days` ngày, luật coi hợp đồng đó là không xác định thời hạn; hệ thống chỉ cảnh báo, không tự đổi loại hợp đồng | Bộ luật Lao động 2019, Điều 20 | Assumed |
| BR-028 | Lưu hợp đồng thử việc | Phải có ngày kết thúc, và thời gian thử việc không quá `probation_max_days` của nhóm công việc đã chọn; vi phạm thì từ chối | Bộ luật Lao động 2019, Điều 25 | Assumed |
| BR-029 | Xác định hợp đồng sắp hết hạn | Hợp đồng thử việc hoặc xác định thời hạn có ngày kết thúc trong `contract_expiry_warning_days` ngày tới, và nhân viên chưa có hợp đồng tiếp theo | A-003 | Assumed |
| BR-037 | Lưu số hợp đồng | Số hợp đồng không trùng trong toàn hệ thống | A-003 | Assumed |

**Nhật ký và quyền xem**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-030 | Tạo, sửa hoặc xóa hồ sơ, quá trình công tác, hợp đồng, phòng ban, chức danh, tài khoản hoặc vai trò | Ghi nhật ký: người làm, thời điểm, đối tượng, giá trị trước và sau, lý do nếu có | A-003 | Assumed |
| BR-031 | Bất kỳ ai cố sửa hoặc xóa nhật ký | Hệ thống không có thao tác nào cho phép việc đó | A-003 | Assumed |
| BR-032 | Hiển thị danh bạ | Chỉ gồm nhân viên đang làm; chỉ hiện họ tên, chức danh, phòng ban, email và điện thoại công việc | A-003 | Assumed |
| BR-033 | Quản lý xem nhân viên trong phạm vi | Xem được thông tin công việc, liên hệ công việc và quá trình công tác; không xem được CCCD, ngày sinh, giới tính, địa chỉ, tài khoản ngân hàng, liên hệ khẩn cấp và hợp đồng | A-003 | Assumed |

**Lịch làm việc và loại nghỉ**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-038 | Xác định ngày D có phải ngày làm việc của nhân viên X không | Là ngày làm việc nếu D thuộc các ngày làm việc trong tuần của ca của X tại D và không phải ngày nghỉ lễ, hoặc nếu D là ngày làm bù do HR khai báo | A-003, A-005 | Assumed |
| BR-039 | Bắt đầu một năm mới | HR khai báo ngày nghỉ lễ và ngày làm bù của năm đó theo Điều 112 Bộ luật Lao động và thông báo của Chính phủ | Bộ luật Lao động 2019, Điều 112 | Assumed |
| BR-040 | Tạo hoặc sửa loại nghỉ | Mỗi loại có tên không trùng, chế độ hưởng (công ty trả lương, BHXH chi trả hoặc không hưởng lương), có trừ phép năm hay không, số ngày tối đa mỗi đơn nếu có | Chủ dự án, 2026-10-30 | Confirmed |
| BR-041 | Quản lý loại Phép năm | Hệ thống có đúng một loại trừ số dư phép năm là Phép năm; loại này không xóa và không ngừng dùng được | A-003 | Assumed |
| BR-042 | Xóa loại nghỉ đã có đơn | Từ chối; chỉ ngừng dùng được. Loại ngừng dùng không chọn được cho đơn mới | A-003 | Assumed |

**Đơn nghỉ và duyệt**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-043 | Nhập ngày nghỉ | Đơn có ngày và buổi bắt đầu, ngày và buổi kết thúc. Đơn vị nhỏ nhất là một buổi, tức nửa ngày | A-003 | Assumed |
| BR-044 | Tính số ngày của đơn | Số ngày bằng số ngày làm việc trong khoảng nghỉ theo BR-038; một buổi tính 0,5 ngày. Số ngày bằng 0 thì từ chối | A-003 | Assumed |
| BR-045 | Gửi hoặc ghi một đơn | Từ chối nếu chồng buổi với đơn khác đang chờ duyệt hoặc đã duyệt của cùng nhân viên | A-003 | Assumed |
| BR-046 | Gửi hoặc ghi một đơn | Mọi ngày của đơn phải nằm trong khoảng từ ngày vào làm tới ngày làm việc cuối cùng, nếu đã có | A-003 | Assumed |
| BR-047 | Gửi đơn của loại có số ngày tối đa mỗi đơn | Từ chối nếu số ngày của đơn vượt mức đó | A-003 | Assumed |
| BR-056 | Gửi đơn | Người duyệt là quản lý trực tiếp của nhân viên tại ngày gửi (BR-012). Nhân viên không có quản lý trực tiếp thì HR duyệt | Chủ dự án, 2026-10-30 | Confirmed |
| BR-057 | Người duyệt không còn là quản lý trực tiếp của người gửi trước khi duyệt, ví dụ do chuyển phòng ban hoặc nghỉ việc | Đơn chuyển cho quản lý trực tiếp hiện tại; không có thì chuyển cho HR | A-003 | Assumed |
| BR-058 | HR duyệt hoặc từ chối một đơn không giao cho mình | Được phép; nhật ký ghi là HR duyệt thay | A-003 | Assumed |
| BR-059 | Từ chối đơn | Lý do từ chối là bắt buộc | A-003 | Assumed |
| BR-060 | Duyệt đơn | Người gửi không duyệt được đơn của chính mình, trừ trường hợp ở EC-035 | A-003 | Assumed |
| BR-061 | Hủy hoặc rút ngắn đơn | Nhân viên hủy được đơn đang chờ duyệt bất kỳ lúc nào, và đơn đã duyệt khi chưa tới ngày bắt đầu. Đơn đã bắt đầu chỉ HR hủy hoặc rút ngắn được, kèm lý do. Phép năm của phần bị hủy được hoàn lại | A-003 | Assumed |
| BR-062 | Gửi đơn cho ngày đã qua | Nhân viên chỉ gửi được nếu ngày bắt đầu không sớm hơn hôm nay quá `leave_backdate_days` ngày; HR ghi đơn thay thì không giới hạn | A-003 | Assumed |
| BR-063 | HR ghi đơn thay nhân viên | Đơn có trạng thái Đã duyệt ngay; nhật ký ghi HR là người ghi | A-003 | Assumed |
| BR-066 | Đơn được gửi, duyệt, từ chối, hủy hoặc tính lại | Gửi thông báo trong hệ thống: cho người duyệt khi đơn được gửi; cho người gửi trong các trường hợp còn lại | A-003 | Assumed |
| BR-067 | Quản lý xem đơn của nhân viên trong phạm vi | Thấy ngày nghỉ và loại nghỉ; chỉ người duyệt, HR và chính nhân viên thấy lý do nghỉ | A-003 | Assumed |

**Phép năm**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-048 | Xác định phép năm cơ bản của nhân viên | Mặc định `annual_leave_base_days` ngày; HR đặt 14 hoặc 16 ngày cho nhân viên thuộc các trường hợp ở Điều 113. Cứ đủ `seniority_step_years` năm làm việc thì thêm 1 ngày. Thay đổi có tác dụng từ tháng kế tiếp | Bộ luật Lao động 2019, Điều 113 và Điều 114 | Assumed |
| BR-049 | Tới ngày cuối của một tháng đủ điều kiện | Nhân viên được cộng 1/12 phép năm cơ bản của mình | Chủ dự án, 2026-10-30; Bộ luật Lao động 2019, Điều 113 | Confirmed |
| BR-050 | Xét một tháng có đủ điều kiện để cộng phép không | Tháng vào làm hoặc nghỉ việc chỉ đủ điều kiện khi số ngày làm việc và nghỉ có hưởng lương đạt `accrual_min_month_ratio` số ngày làm việc của tháng. Nghỉ không lương vượt `unpaid_leave_counted_months` tháng và nghỉ ốm vượt `sick_leave_counted_months` tháng cộng dồn trong năm không được tính là thời gian làm việc | Nghị định 145/2020/NĐ-CP, Điều 65 và Điều 66 | Assumed |
| BR-051 | Tới ngày 1/1 | Phép năm chưa dùng của năm trước thành phép tồn, tối đa `carryover_max_days` ngày; phần vượt bị hủy. Phép tồn còn lại bị hủy sau ngày `carryover_expiry` | Chủ dự án, 2026-10-30 | Confirmed |
| BR-052 | Trừ phép cho một ngày nghỉ phép năm ở ngày D | Trừ vào phép tồn trước, nếu D không sau hạn phép tồn và phép tồn còn; phần còn lại trừ vào phép cộng của năm chứa D | A-003 | Assumed |
| BR-053 | Gửi hoặc duyệt đơn phép năm | Từ chối nếu tại một ngày nghỉ nào đó, sau khi trừ theo BR-052, số phép bị âm. Số phép tại ngày D gồm số dư hôm nay, phép sẽ được cộng tới cuối tháng trước D, trừ các đơn phép năm khác đang chờ duyệt hoặc đã duyệt | A-003 | Assumed |
| BR-054 | Số dư phép thay đổi | Mỗi thay đổi là một biến động phép: cộng hằng tháng, chuyển phép tồn, hủy phép, sử dụng, hoàn lại hoặc điều chỉnh. Số dư bằng tổng các biến động. Biến động không sửa, không xóa; sai thì ghi biến động bù | A-003 | Assumed |
| BR-055 | HR điều chỉnh số dư | Lý do là bắt buộc; điều chỉnh được ghi thành một biến động | A-003 | Assumed |
| BR-064 | HR thêm hoặc bỏ ngày nghỉ lễ hoặc ngày làm bù | Số ngày của các đơn đã duyệt hoặc đang chờ mà chưa bắt đầu được tính lại; chênh lệch phép năm được trừ hoặc hoàn; nhân viên được thông báo. Đơn đã bắt đầu không tự đổi | A-003 | Assumed |
| BR-065 | Việc nghỉ việc có hiệu lực | Các đơn có ngày sau ngày làm việc cuối cùng bị hủy. Số ngày phép năm chưa nghỉ tính tới ngày làm việc cuối cùng được chốt để thanh toán ở M4 | Bộ luật Lao động 2019, Điều 113 | Assumed |

**Ca và chấm công**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-068 | Tạo hoặc sửa ca | Ca có tên không trùng, giờ bắt đầu, giờ kết thúc, khoảng nghỉ giữa ca nếu có, nghỉ giữa ca có tính vào giờ làm không, và các ngày làm việc trong tuần. Giờ kết thúc sớm hơn giờ bắt đầu nghĩa là ca qua nửa đêm. Ca chia thành buổi sáng và buổi chiều tại khoảng nghỉ giữa ca, hoặc tại điểm giữa ca nếu không có nghỉ | Chủ dự án, 2026-10-30; A-003 | Confirmed |
| BR-069 | Tính giờ làm chuẩn của ca | Bằng thời gian từ giờ bắt đầu tới giờ kết thúc, trừ nghỉ giữa ca nếu nghỉ không tính vào giờ làm. Vượt `normal_hours_max_per_day` thì cảnh báo; HR xác nhận thì vẫn lưu | Bộ luật Lao động 2019, Điều 105 | Assumed |
| BR-070 | Gán ca | Từ ngày vào làm, mỗi ngày nhân viên có đúng một ca; các lần gán ca có ngày hiệu lực, không chồng, không hở. Nhân viên mới nhận ca `default_shift` từ ngày vào làm | Chủ dự án, 2026-10-30; A-003 | Confirmed |
| BR-071 | Tính giờ làm ban đêm | Giờ làm trong khoảng từ `night_start` tới `night_end` là giờ làm ban đêm, kể cả giờ làm thêm | Bộ luật Lao động 2019, Điều 106 | Assumed |
| BR-072 | Khai báo mã chấm công | Mỗi nhân viên có tối đa một mã chấm công. Mã không trùng giữa các nhân viên đang làm hoặc sắp vào làm; mã của người đã nghỉ việc được dùng lại | A-003 | Assumed |
| BR-073 | Nhập file chấm công | Mỗi dòng gồm mã chấm công và thời điểm. Dòng có mã không khớp nhân viên nào hoặc thời điểm thuộc tháng đã chốt bị bỏ qua và được liệt kê. Lượt chấm trùng cùng nhân viên, cùng thời điểm chỉ lưu một lần | Chủ dự án, 2026-10-30; A-006 | Assumed |
| BR-074 | Xác định giờ vào và giờ ra của ngày ca D | Lượt chấm thuộc ngày ca D nếu nằm trong khoảng từ `punch_window_before` phút trước giờ bắt đầu ca tới `punch_window_after` phút sau giờ kết thúc ca. Giờ vào là lượt sớm nhất, giờ ra là lượt muộn nhất trong khoảng đó. Ca qua nửa đêm thuộc ngày bắt đầu ca | A-003 | Assumed |
| BR-075 | Ngày làm việc có giờ vào và giờ ra khác nhau | Ngày được tính đủ công. Phút đi muộn là số phút giờ vào trễ hơn giờ bắt đầu ca; phút về sớm là số phút giờ ra sớm hơn giờ kết thúc ca. Số phút không quá `late_grace_minutes` được ghi là 0. Đi muộn, về sớm không làm giảm công | Chủ dự án, 2026-10-30 | Confirmed |
| BR-076 | Ngày làm việc có đơn nghỉ nửa ngày đã duyệt | Buổi nghỉ tính theo loại nghỉ của đơn; buổi còn lại tính công như BR-075 nhưng so với giờ bắt đầu và kết thúc của buổi đó | A-003 | Assumed |
| BR-077 | Ngày làm việc thiếu chấm công | Có đúng một lượt chấm thì ngày ở trạng thái Thiếu chấm công. Không có lượt chấm nào và không có đơn nghỉ thì ở trạng thái Vắng chưa xử lý. Cả hai cần giải trình hoặc HR xử lý trước khi chốt | A-003 | Assumed |
| BR-078 | Tổng phút đi muộn và về sớm của một ngày vượt `anomaly_minutes` | Ngày được đánh dấu bất thường để quản lý và HR xem; công không đổi | A-003 | Assumed |
| BR-079 | Có lượt chấm vào ngày không phải ngày làm việc | Lượt chấm không tạo công. Chỉ giờ làm thêm đã duyệt được tính; lượt chấm không có đơn làm thêm được đánh dấu cho HR | A-003 | Assumed |
| BR-080 | Có lượt chấm vào ngày có đơn nghỉ cả ngày đã duyệt | Ngày vẫn là ngày nghỉ theo đơn; ngày được đánh dấu cho HR | A-003 | Assumed |

**Giải trình và làm thêm giờ**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-081 | Nhân viên gửi giải trình chấm công | Giải trình cho một ngày làm việc thuộc tháng chưa chốt, gồm giờ vào hoặc giờ ra đề nghị và lý do. Người duyệt theo BR-056 tới BR-059. Được duyệt thì giờ đề nghị thay giờ từ máy cho ngày đó | A-003 | Assumed |
| BR-082 | HR xử lý ngày Thiếu chấm công hoặc Vắng chưa xử lý | HR ghi giờ vào và giờ ra, hoặc ghi Vắng không lý do. Lý do là bắt buộc; nhật ký ghi lại | A-003 | Assumed |
| BR-083 | Nhân viên đăng ký làm thêm giờ | Đơn gồm ngày, giờ bắt đầu, giờ kết thúc, lý do, và phải được gửi trước giờ bắt đầu. Người duyệt theo BR-056 tới BR-059 | Chủ dự án, 2026-10-30 | Confirmed |
| BR-084 | Gửi hoặc duyệt đơn làm thêm giờ | Từ chối nếu vượt một trong các giới hạn: ngày làm việc không quá `ot_max_daily_ratio` giờ làm chuẩn của ca; ngày không phải ngày làm việc không quá `ot_max_hours_non_working_day` giờ; mỗi tháng không quá `ot_max_hours_per_month` giờ; mỗi năm không quá `ot_max_hours_per_year` giờ. Giới hạn tính cả đơn đang chờ và đã duyệt | Bộ luật Lao động 2019, Điều 107; Nghị định 145/2020/NĐ-CP, Điều 60 | Assumed |
| BR-085 | Tính giờ làm thêm thực tế | Bằng phần giao giữa khoảng đã duyệt và khoảng từ giờ vào tới giờ ra. Giờ làm thêm được phân loại theo ngày làm việc, ngày nghỉ hằng tuần hoặc ngày nghỉ lễ, và tách phần ban đêm theo BR-071 | Chủ dự án, 2026-10-30; Bộ luật Lao động 2019, Điều 98 | Confirmed |
| BR-086 | Đăng ký làm thêm vào ngày làm việc | Khoảng làm thêm phải nằm ngoài giờ ca của ngày đó và không chồng đơn làm thêm khác | A-003 | Assumed |
| BR-087 | Đăng ký làm thêm vào ngày có đơn nghỉ cả ngày đã duyệt | Từ chối | A-003 | Assumed |

**Bảng công**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-088 | Xác định kỳ công | Kỳ công là tháng dương lịch | A-007 | Assumed |
| BR-089 | HR chốt bảng công tháng | Từ chối nếu còn đơn nghỉ, đơn làm thêm hay giải trình đang chờ duyệt có ngày trong tháng, hoặc còn ngày Thiếu chấm công hay Vắng chưa xử lý | A-003 | Assumed |
| BR-090 | Tháng đã chốt | Không tạo, duyệt, hủy hay sửa đơn nghỉ, đơn làm thêm, giải trình có ngày trong tháng; không nhập lượt chấm; không thêm hay bỏ ngày nghỉ lễ, ngày làm bù. Gán ca hay thay đổi công tác có hiệu lực trong tháng đó vẫn lưu được, nhưng không đổi bảng công đã chốt, và HR được cảnh báo | A-003 | Assumed |
| BR-091 | HR mở lại bảng công đã chốt | Lý do là bắt buộc; chỉ được khi bảng lương của tháng đó chưa chốt | A-003 | Assumed |
| BR-092 | Tổng hợp bảng công tháng của một nhân viên | Gồm số ngày làm việc chuẩn, số công, số ngày nghỉ theo từng loại nghỉ, số ngày vắng không lý do, số lần và tổng phút đi muộn, về sớm, số giờ làm thêm theo từng loại, số giờ làm ban đêm. Chỉ tính các ngày trong khoảng làm việc của nhân viên | A-003 | Assumed |

**Lương và phụ cấp**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-093 | HR ghi bản ghi lương với ngày hiệu lực D | Bản ghi gồm lương cơ bản, lương đóng bảo hiểm, các phụ cấp và lý do. Bản ghi chứa D kết thúc ở D−1; bản ghi mới kéo dài tới ngày trước bản ghi kế tiếp đã có. Từ bản ghi đầu tiên tới ngày làm việc cuối cùng, các bản ghi không chồng, không hở | A-003 | Assumed |
| BR-094 | Lưu lương cơ bản | Từ chối nếu thấp hơn lương tối thiểu vùng của `company_region` tại ngày hiệu lực | Bộ luật Lao động 2019, Điều 90 và Điều 91 | Assumed |
| BR-095 | Lưu lương đóng bảo hiểm | HR nhập riêng, không tự suy ra từ lương và phụ cấp. Thấp hơn lương cơ bản thì cảnh báo; HR xác nhận thì vẫn lưu | Chủ dự án, 2026-10-30 | Confirmed |
| BR-096 | Lưu lương đóng bảo hiểm thấp hơn lương tối thiểu vùng tại ngày hiệu lực | Từ chối | Luật Bảo hiểm xã hội 2024, Điều 31 | Assumed |
| BR-097 | Tạo hoặc sửa loại phụ cấp | Tên không trùng, không phân biệt hoa thường. Cách tính là theo công hoặc cố định theo tháng. Chế độ thuế là chịu thuế, miễn thuế, hoặc miễn thuế trong mức kèm mức miễn mỗi tháng | A-003 | Assumed |
| BR-098 | Ghi bản ghi lương có ngày hiệu lực thuộc tháng có bảng lương đã chốt | Được lưu; bảng lương đã chốt không đổi. Hệ thống hiện chênh lệch thực lĩnh ước tính của từng tháng đã chốt bị ảnh hưởng, để HR thêm khoản truy lĩnh hoặc truy thu vào bảng lương chưa chốt | A-003 | Assumed |

**Thông tin thuế và bảo hiểm**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-099 | HR ghi người phụ thuộc | Có họ tên, quan hệ, ngày sinh, số định danh hoặc mã số thuế, tháng bắt đầu; tháng kết thúc nếu có. Từ chối nếu cùng số định danh đang được tính cho nhân viên khác trong một tháng chung | Luật Thuế thu nhập cá nhân | Assumed |
| BR-100 | Xác định nhân viên phải đóng bảo hiểm bắt buộc trong tháng | Phải đóng nếu có hợp đồng xác định thời hạn hoặc không xác định thời hạn hiệu lực trong tháng. Tháng chỉ có hợp đồng thử việc thì không đóng | Luật Bảo hiểm xã hội 2024, Điều 2 | Assumed |
| BR-101 | Tháng có từ `insurance_skip_unpaid_days` ngày làm việc trở lên nhân viên không làm và không được công ty trả lương, kể cả ngày ngoài khoảng làm việc | Không đóng BHXH, BHYT, BHTN tháng đó | Luật Bảo hiểm xã hội 2024 | Assumed |

**Tính lương**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-102 | HR tính bảng lương của một tháng | Mỗi tháng có một bảng lương cho cả công ty, kỳ lương trùng kỳ công (BR-088). Chỉ tính được khi bảng công của tháng đã chốt. Bảng lương gồm mọi nhân viên có ít nhất một ngày trong khoảng làm việc thuộc tháng | A-003 | Assumed |
| BR-103 | Xác định công chuẩn của nhân viên trong tháng | Số ngày làm việc theo BR-038 trên mọi ngày của tháng. Ngày ngoài khoảng làm việc dùng ca của ngày làm việc gần nhất | A-003 | Assumed |
| BR-104 | Xác định công hưởng lương | Bằng công theo bảng công đã chốt cộng số ngày nghỉ thuộc loại nghỉ công ty trả lương. Nghỉ BHXH chi trả, nghỉ không hưởng lương và vắng không lý do không được tính | A-003 | Assumed |
| BR-105 | Tính lương theo công | Với mỗi bản ghi lương có hiệu lực trong tháng: lương cơ bản × công hưởng lương trong khoảng của bản ghi ÷ công chuẩn. Lương theo công là tổng các phần đó | Chủ dự án, 2026-10-30 | Confirmed |
| BR-106 | Tính phụ cấp | Theo từng bản ghi lương như BR-105. Phụ cấp theo công: mức × công hưởng lương ÷ công chuẩn. Phụ cấp cố định theo tháng: mức × số ngày làm việc trong khoảng làm việc ÷ công chuẩn, nên chỉ giảm khi vào làm hoặc nghỉ việc giữa tháng | A-003 | Assumed |
| BR-107 | Tính đơn giá giờ của một ngày | Lương cơ bản của bản ghi có hiệu lực tại ngày đó ÷ công chuẩn ÷ giờ làm chuẩn của ca tại ngày đó | Nghị định 145/2020/NĐ-CP, Điều 55 | Assumed |
| BR-108 | Tính tiền làm thêm giờ | Tổng theo từng ngày: giờ làm thêm thực tế (BR-085) × đơn giá giờ × hệ số. Hệ số ban ngày theo loại ngày: `ot_rate_working_day`, `ot_rate_weekly_off`, `ot_rate_holiday`. Giờ làm thêm ban đêm có hệ số bằng hệ số ban ngày + `night_work_premium` + `ot_night_extra` × hệ số ban ngày | Bộ luật Lao động 2019, Điều 98; Nghị định 145/2020/NĐ-CP, Điều 57 | Assumed |
| BR-109 | Tính tiền làm ban đêm không phải làm thêm giờ | Giờ làm ban đêm trong giờ ca (BR-071) × đơn giá giờ × `night_work_premium` | Bộ luật Lao động 2019, Điều 98 | Assumed |
| BR-110 | Tính bảo hiểm bắt buộc | Mức đóng là lương đóng bảo hiểm của bản ghi có hiệu lực tại ngày cuối cùng của tháng mà nhân viên còn trong khoảng làm việc. BHXH và BHYT chặn ở `insurance_cap_multiplier` × mức tham chiếu; BHTN chặn ở `insurance_cap_multiplier` × lương tối thiểu vùng. Phần nhân viên và phần công ty bằng mức đóng × tỷ lệ tương ứng. Kinh phí công đoàn do công ty đóng, bằng mức đóng BHXH × `union_fee_rate` | Luật Bảo hiểm xã hội 2024; Luật Việc làm; Luật Công đoàn | Assumed |
| BR-111 | Tính thu nhập chịu thuế | Tổng thu nhập trừ các phần được miễn: phụ cấp miễn thuế; phần phụ cấp miễn thuế trong mức; phần tiền làm thêm giờ cao hơn 100% đơn giá giờ; toàn bộ tiền làm ban đêm theo BR-109; khoản điều chỉnh cộng không chịu thuế | Luật Thuế thu nhập cá nhân, Điều 4 | Assumed |
| BR-112 | Tính thuế TNCN của nhân viên có hợp đồng từ 3 tháng trở lên hiệu lực trong tháng | Thu nhập tính thuế = thu nhập chịu thuế − bảo hiểm nhân viên đóng − `pit_personal_deduction` − `pit_dependent_deduction` × số người phụ thuộc có hiệu lực trong tháng; âm thì lấy 0. Thuế tính theo `pit_brackets` lũy tiến từng phần. Tham số lấy giá trị có hiệu lực tại ngày cuối tháng (BR-123) | Chủ dự án, 2026-10-30; Luật Thuế thu nhập cá nhân | Assumed |
| BR-113 | Tính thuế TNCN của nhân viên chỉ có hợp đồng thử việc hoặc hợp đồng dưới 3 tháng | Khấu trừ `short_contract_tax_rate` × thu nhập chịu thuế nếu tổng thu nhập của tháng từ `short_contract_tax_threshold` trở lên. Không khấu trừ nếu nhân viên có cam kết thu nhập cho năm đó | Thông tư 111/2013/TT-BTC, Điều 25 | Assumed |
| BR-114 | Tính thực lĩnh | Thực lĩnh = tổng thu nhập − bảo hiểm nhân viên đóng − thuế TNCN + khoản điều chỉnh cộng − khoản điều chỉnh trừ. Mỗi dòng của phiếu làm tròn tới đồng, từ 0,5 trở lên làm tròn lên; tổng tính từ các dòng đã làm tròn | A-003 | Assumed |
| BR-115 | HR thêm, sửa hoặc xóa khoản điều chỉnh | Chỉ trên bảng lương chưa chốt. Khoản điều chỉnh gồm tên, cộng hay trừ, số tiền, có chịu thuế không nếu là khoản cộng, và lý do bắt buộc. Khoản trừ không làm giảm thu nhập chịu thuế. Lưu xong thì phiếu được tính lại | A-003 | Assumed |
| BR-116 | HR tính lại bảng lương chưa chốt | Mọi dòng do hệ thống tính được thay theo dữ liệu và tham số tại lúc tính; khoản điều chỉnh được giữ | A-003 | Assumed |
| BR-117 | HR chốt bảng lương | Từ chối nếu bảng lương Cần tính lại, còn phiếu có lỗi như thiếu bản ghi lương, hoặc còn phiếu có thực lĩnh âm. Cảnh báo không chặn việc chốt. Chốt xong thì phiếu lương được công bố | A-003 | Assumed |
| BR-118 | Bảng lương đã chốt | Không tính lại, không sửa khoản điều chỉnh, không mở lại. Sai sót được sửa bằng khoản truy lĩnh hoặc truy thu ở bảng lương chưa chốt | A-003 | Assumed |
| BR-119 | Dữ liệu nguồn của một tháng đổi sau khi bảng lương tháng đó đã tính và chưa chốt | Bảng lương chuyển sang Cần tính lại. Dữ liệu nguồn gồm bảng công, bản ghi lương, người phụ thuộc, thông tin thuế và bảo hiểm, hợp đồng, loại phụ cấp và tham số lương | A-003 | Assumed |
| BR-120 | Nhân viên có ngày làm việc cuối cùng trong tháng và còn phép năm chưa nghỉ theo BR-065 | Phiếu lương tháng đó có thêm khoản chịu thuế: số ngày phép chưa nghỉ × lương ngày. Lương ngày = bình quân lương cơ bản của `unused_leave_avg_months` tháng liền trước tháng nghỉ việc ÷ bình quân công chuẩn của các tháng đó. Làm chưa đủ số tháng đó thì lấy bình quân các tháng đã làm | Bộ luật Lao động 2019, Điều 113; Nghị định 145/2020/NĐ-CP, Điều 67 | Assumed |
| BR-121 | Nhân viên nghỉ việc giữa tháng | Lương được tính trong bảng lương của tháng đó như mọi người, chỉ gồm các ngày trong khoảng làm việc; không có kỳ tính lương riêng | A-003 | Assumed |
| BR-122 | Xem lương, phụ cấp, phiếu lương, người phụ thuộc, thông tin thuế và bảo hiểm | Chỉ HR và chính nhân viên xem được. Quản lý không xem được, kể cả nhân viên trong phạm vi. Nhân viên chỉ thấy phiếu lương của bảng lương đã chốt | A-003 | Assumed |
| BR-123 | Lưu một giá trị của tham số lương | Mỗi giá trị có ngày hiệu lực. Bảng lương dùng giá trị có hiệu lực tại ngày cuối tháng; kiểm mức sàn ở BR-094, BR-096 dùng giá trị tại ngày hiệu lực của bản ghi lương. Giá trị đã được dùng trong bảng lương đã chốt không sửa, không xóa được | A-003 | Assumed |
| BR-124 | Tạo, sửa hoặc xóa bản ghi lương, người phụ thuộc, thông tin thuế và bảo hiểm, loại phụ cấp, tham số lương, khoản điều chỉnh; tính hoặc chốt bảng lương | Ghi nhật ký như BR-030 | A-003 | Assumed |
| BR-125 | Bảng lương được chốt | Mỗi nhân viên có phiếu lương nhận thông báo trong hệ thống | A-003 | Assumed |
| BR-126 | Xuất danh sách chuyển khoản | Chỉ xuất được khi bảng lương đã chốt. Mỗi nhân viên có thực lĩnh lớn hơn 0 một dòng gồm họ tên, số tài khoản, ngân hàng, số tiền. Nhân viên thiếu số tài khoản không có trong file và được cảnh báo khi chốt | A-003 | Assumed |

**Báo cáo**

| ID | When | Then | Source | Status |
|---|---|---|---|---|
| BR-127 | Xác định dữ liệu trong một báo cáo | HR thấy mọi nhân viên. Quản lý chỉ thấy nhân viên trong phạm vi tại ngày cuối của kỳ báo cáo, hoặc tại hôm nay nếu kỳ chưa kết thúc. Mỗi nhân viên được xếp vào phòng ban tại ngày cuối cùng của kỳ mà người đó còn trong khoảng làm việc | A-003 | Assumed |
| BR-128 | Quản lý xem chi phí lương | Chỉ thấy số tổng hợp theo phòng ban trong phạm vi, từ bảng lương đã chốt; không thấy số liệu từng người | Chủ dự án, 2026-10-30 | Confirmed |
| BR-129 | Quản lý xem số liệu tổng hợp về lương, giới tính hay độ tuổi của một nhóm có dưới `report_min_group_size` người | Số liệu của nhóm đó được gộp vào phòng ban cha gần nhất. Nếu cả phạm vi có dưới ngưỡng thì không hiện số liệu và ghi lý do. HR không bị áp ngưỡng này | A-003 | Assumed |
| BR-130 | Báo cáo chi phí lương gồm một tháng có bảng lương chưa chốt | Quản lý không thấy tháng đó. HR thấy, kèm nhãn tạm tính | A-003 | Assumed |
| BR-131 | Tính chi phí lương của một nhân viên trong một tháng | Tổng thu nhập trên phiếu lương cộng phần công ty đóng BHXH, BHYT, BHTN và kinh phí công đoàn. Khoản điều chỉnh tính vào tháng của bảng lương chứa nó, kể cả truy lĩnh cho tháng trước | A-003 | Assumed |
| BR-132 | Tính biến động nhân sự của một phòng ban trong một kỳ | Đầu kỳ: số nhân viên thuộc phòng ban ngày đầu kỳ. Vào mới: ngày vào làm trong kỳ. Nghỉ việc: ngày làm việc cuối cùng trong kỳ. Chuyển đến, chuyển đi: thay đổi công tác có ngày hiệu lực trong kỳ. Cuối kỳ = đầu kỳ + vào mới − nghỉ việc + chuyển đến − chuyển đi. Tỷ lệ nghỉ việc = nghỉ việc ÷ ((đầu kỳ + cuối kỳ) ÷ 2). Hồ sơ đã hủy tiếp nhận không được tính | A-003 | Assumed |
| BR-133 | Xem báo cáo cơ cấu nhân sự | HR chọn được một ngày bất kỳ; báo cáo dùng dữ liệu có hiệu lực tại ngày đó. Quản lý chỉ xem tại hôm nay và không thấy các chiều giới tính, độ tuổi, loại hợp đồng | A-003 | Assumed |
| BR-134 | Báo cáo chấm công của một tháng | Tháng đã chốt dùng bảng công đã chụp khi chốt. Tháng đang mở dùng công tính tới hiện tại, kèm nhãn tạm tính | A-003 | Assumed |
| BR-135 | Báo cáo nghỉ phép | Số ngày nghỉ chỉ tính từ đơn đã duyệt, chia theo ngày làm việc trong kỳ báo cáo. Số dư phép tính theo BR-054 tại ngày báo cáo | A-003 | Assumed |
| BR-136 | Xuất một báo cáo | File chỉ chứa số liệu người xuất đang thấy trên màn hình, cùng bộ lọc và cùng luật gộp nhóm. Nhật ký ghi người xuất, tên báo cáo, bộ lọc và thời điểm | A-003 | Assumed |
| BR-137 | Hiển thị trang tổng quan | Mỗi con số tính theo phạm vi của người xem; bấm vào thì mở danh sách chi tiết mà người đó có quyền xem | A-003 | Assumed |
| BR-138 | Mở một báo cáo | Báo cáo đọc dữ liệu hiện có tại lúc mở; không lưu bản chụp riêng. Chỉ bảng công và bảng lương đã chốt là số liệu cố định | A-003 | Assumed |

### Parameters

Giá trị lấy từ Bộ luật Lao động và Nghị định 145/2020/NĐ-CP chưa được đối chiếu văn bản gốc, xem
[questions](../project/questions.md). Giá trị không có nguồn luật là đề xuất của agent, chờ HR công ty xác nhận. Từ M4, các giá trị
đánh dấu "tham số lương" có ngày hiệu lực và HR cập nhật được (BR-123); giá trị ghi ở đây là giá trị ban đầu, chờ đối
chiếu theo Q-008 và Q-023.

| Parameter | Meaning and unit | Value | Used by |
|---|---|---|---|
| `max_failed_logins` | Số lần nhập sai mật khẩu liên tiếp trước khi khóa tạm | 5 | BR-003 |
| `lockout_minutes` | Thời gian khóa tạm, phút | 15 | BR-003 |
| `min_password_length` | Độ dài tối thiểu của mật khẩu, ký tự | 8 | BR-036 |
| `employee_code_format` | Mẫu mã nhân viên do hệ thống tự cấp | `NV` cùng 5 chữ số tăng dần, ví dụ `NV00001` | BR-015 |
| `fixed_term_max_months` | Thời hạn tối đa của hợp đồng xác định thời hạn, tháng | 36 | BR-024 |
| `contract_auto_convert_days` | Số ngày sau khi hợp đồng xác định thời hạn hết hạn mà luật coi là không xác định thời hạn, nếu chưa ký hợp đồng mới | 30 | BR-027 |
| `probation_max_days` | Thời gian thử việc tối đa theo nhóm công việc | Quản lý doanh nghiệp: 180 ngày. Cần trình độ cao đẳng trở lên: 60 ngày. Trung cấp, công nhân kỹ thuật, nhân viên nghiệp vụ: 30 ngày. Công việc khác: 6 ngày làm việc | BR-028 |
| `contract_expiry_warning_days` | Số ngày trước ngày kết thúc hợp đồng để đưa vào danh sách sắp hết hạn | 30 | BR-029 |
| `default_shift` | Ca gán cho nhân viên mới | Ca hành chính 8:00–17:00, nghỉ 12:00–13:00 không tính giờ làm, thứ Hai tới thứ Sáu | BR-038, BR-070 |
| `annual_leave_base_days` | Phép năm cơ bản mặc định, ngày | 12 | BR-048 |
| `seniority_step_years` | Số năm làm việc để được thêm 1 ngày phép năm | 5 | BR-048 |
| `accrual_min_month_ratio` | Tỷ lệ ngày làm việc tối thiểu để tháng vào làm hoặc nghỉ việc được cộng phép | 50% | BR-050 |
| `unpaid_leave_counted_months` | Số tháng nghỉ không lương cộng dồn trong năm vẫn được tính là thời gian làm việc | 1 | BR-050 |
| `sick_leave_counted_months` | Số tháng nghỉ ốm cộng dồn trong năm vẫn được tính là thời gian làm việc | 2 | BR-050 |
| `carryover_max_days` | Số ngày phép tồn tối đa được chuyển sang năm sau | 5 | BR-051 |
| `carryover_expiry` | Ngày cuối cùng dùng được phép tồn, tính trong năm mới | 31/3 | BR-051 |
| `leave_backdate_days` | Số ngày tối đa nhân viên được gửi đơn cho ngày đã qua | 7 | BR-062 |
| `normal_hours_max_per_day` | Giờ làm việc bình thường tối đa trong một ngày | 8 | BR-069 |
| `night_start`, `night_end` | Khoảng giờ làm ban đêm | 22:00 tới 06:00 | BR-071 |
| `punch_window_before` | Số phút trước giờ bắt đầu ca mà lượt chấm vẫn thuộc ngày ca đó | 180 | BR-074 |
| `punch_window_after` | Số phút sau giờ kết thúc ca mà lượt chấm vẫn thuộc ngày ca đó | 300 | BR-074 |
| `late_grace_minutes` | Số phút đi muộn hoặc về sớm được bỏ qua | 5 | BR-075 |
| `anomaly_minutes` | Tổng phút đi muộn và về sớm trong một ngày để đánh dấu bất thường | 120 | BR-078 |
| `ot_max_daily_ratio` | Giờ làm thêm tối đa trong một ngày làm việc, tính theo giờ làm chuẩn của ca | 50% | BR-084 |
| `ot_max_hours_non_working_day` | Giờ làm thêm tối đa trong một ngày không phải ngày làm việc | 12 | BR-084 |
| `ot_max_hours_per_month` | Giờ làm thêm tối đa trong một tháng | 40 | BR-084 |
| `ot_max_hours_per_year` | Giờ làm thêm tối đa trong một năm; một số ngành được tới 300 giờ theo Điều 107 | 200 | BR-084 |
| `company_region` | Vùng lương tối thiểu của công ty | Vùng I (A-008) | BR-094, BR-096, BR-110 |
| `regional_min_wage` | Tham số lương. Lương tối thiểu tháng theo vùng, đồng | Từ 01/01/2026: vùng I 5.310.000; vùng II 4.730.000; vùng III 4.140.000; vùng IV 3.700.000 | BR-094, BR-096, BR-110 |
| `reference_wage` | Tham số lương. Mức tham chiếu, đồng | 2.340.000 | BR-110 |
| `insurance_cap_multiplier` | Số lần mức tham chiếu hoặc lương tối thiểu vùng làm trần mức đóng bảo hiểm | 20 | BR-110 |
| `employee_insurance_rates` | Tham số lương. Tỷ lệ nhân viên đóng | BHXH 8%; BHYT 1,5%; BHTN 1% | BR-110 |
| `employer_insurance_rates` | Tham số lương. Tỷ lệ công ty đóng | BHXH 17,5%, gồm 0,5% bảo hiểm tai nạn lao động, bệnh nghề nghiệp; BHYT 3%; BHTN 1% | BR-110 |
| `union_fee_rate` | Tham số lương. Tỷ lệ kinh phí công đoàn công ty đóng | 2% | BR-110 |
| `insurance_skip_unpaid_days` | Số ngày làm việc không làm và không hưởng lương trong tháng để không đóng bảo hiểm | 14 | BR-101 |
| `pit_personal_deduction` | Tham số lương. Giảm trừ cho bản thân mỗi tháng, đồng | 15.500.000 | BR-112 |
| `pit_dependent_deduction` | Tham số lương. Giảm trừ cho mỗi người phụ thuộc mỗi tháng, đồng | 6.200.000 | BR-112 |
| `pit_brackets` | Tham số lương. Biểu thuế lũy tiến từng phần theo thu nhập tính thuế tháng | Từ 01/07/2026: tới 10 triệu 5%; trên 10 tới 30 triệu 10%; trên 30 tới 60 triệu 20%; trên 60 tới 100 triệu 30%; trên 100 triệu 35% | BR-112 |
| `short_contract_tax_rate` | Tham số lương. Tỷ lệ khấu trừ thuế với hợp đồng thử việc hoặc dưới 3 tháng | 10% | BR-113 |
| `short_contract_tax_threshold` | Tham số lương. Tổng thu nhập tháng từ mức này thì khấu trừ theo BR-113, đồng | 2.000.000 | BR-113 |
| `ot_rate_working_day` | Hệ số làm thêm ban ngày vào ngày làm việc | 150% | BR-108 |
| `ot_rate_weekly_off` | Hệ số làm thêm ban ngày vào ngày nghỉ hằng tuần | 200% | BR-108 |
| `ot_rate_holiday` | Hệ số làm thêm ban ngày vào ngày nghỉ lễ, chưa gồm tiền lương ngày lễ | 300% | BR-108 |
| `night_work_premium` | Phần trả thêm cho giờ làm ban đêm, theo đơn giá giờ | 30% | BR-108, BR-109 |
| `ot_night_extra` | Phần trả thêm cho giờ làm thêm ban đêm, theo hệ số ban ngày | 20%. Hệ số làm thêm ban đêm vì thế là 210% ngày làm việc, 270% ngày nghỉ hằng tuần, 390% ngày nghỉ lễ | BR-108 |
| `unused_leave_avg_months` | Số tháng liền trước tháng nghỉ việc để tính lương ngày trả phép chưa nghỉ | 6 | BR-120 |
| `report_min_group_size` | Số người tối thiểu của một nhóm để Quản lý thấy số liệu tổng hợp nhạy cảm | 3 | BR-129 |
| `contact_retention_months` | Số tháng sau ngày làm việc cuối cùng để xóa thông tin liên hệ và tài khoản ngân hàng | 12 | BR-140 |
| `retention_years` | Số năm sau ngày làm việc cuối cùng để ẩn danh hồ sơ; theo thời hạn lưu tài liệu kế toán, chờ đối chiếu | 10 | BR-141 |

### Default leave types

Các loại nghỉ có sẵn khi cài hệ thống (US-028). HR sửa, thêm hoặc ngừng dùng được, trừ loại Phép năm (BR-041).

| Leave type | Chế độ hưởng | Trừ phép năm | Tối đa mỗi đơn | Source |
|---|---|---|---|---|
| Phép năm | Công ty trả lương | Có | — | Bộ luật Lao động 2019, Điều 113 |
| Kết hôn | Công ty trả lương | Không | 3 ngày | Bộ luật Lao động 2019, Điều 115 |
| Con kết hôn | Công ty trả lương | Không | 1 ngày | Bộ luật Lao động 2019, Điều 115 |
| Tang cha, mẹ, vợ hoặc chồng, con; cha, mẹ của vợ hoặc chồng | Công ty trả lương | Không | 3 ngày | Bộ luật Lao động 2019, Điều 115 |
| Việc riêng không lương | Không hưởng lương | Không | — | Bộ luật Lao động 2019, Điều 115 |
| Ốm đau | BHXH chi trả | Không | — | Luật Bảo hiểm xã hội 2024 |
| Thai sản | BHXH chi trả | Không | — | Luật Bảo hiểm xã hội 2024 |

### Default allowance types

Các loại phụ cấp có sẵn khi cài hệ thống (US-050), theo cách làm phổ biến ở doanh nghiệp nhỏ (A-009). HR sửa, thêm hoặc
ngừng dùng theo quy chế công ty.

| Allowance type | Cách tính | Chế độ thuế | Source |
|---|---|---|---|
| Ăn giữa ca | Theo công | Miễn thuế trong mức 730.000 đồng mỗi tháng | A-009; mức miễn chờ đối chiếu (Q-023) |
| Trách nhiệm | Cố định theo tháng | Chịu thuế | A-009 |
| Điện thoại | Cố định theo tháng | Chịu thuế | A-009 |
| Đi lại | Cố định theo tháng | Chịu thuế | A-009 |

## Sensitive data

| Data | Purpose | Who may see | Retention |
|---|---|---|---|
| Số CCCD, ngày sinh, giới tính, địa chỉ thường trú | Hồ sơ lao động, hợp đồng; từ M4 dùng cho BHXH và thuế | HR; chính nhân viên | `retention_years` năm sau nghỉ việc (BR-141) |
| Tài khoản ngân hàng | Trả lương, từ M4 | HR; chính nhân viên | `contact_retention_months` tháng sau nghỉ việc (BR-140) |
| Điện thoại, email và địa chỉ cá nhân; người liên hệ khẩn cấp | Liên lạc | HR; chính nhân viên | `contact_retention_months` tháng sau nghỉ việc (BR-140) |
| Hợp đồng lao động | Quản lý quan hệ lao động | HR; chính nhân viên | `retention_years` năm sau nghỉ việc (BR-141) |
| Mật khẩu | Đăng nhập | Không ai, kể cả HR; HR chỉ đặt lại được | Tới khi tài khoản bị xóa |
| Nhật ký thao tác | Truy vết thay đổi | HR | `retention_years` năm; nhật ký về người đã ẩn danh chỉ còn mã nhân viên (BR-141) |
| Lý do nghỉ; đơn nghỉ ốm đau và thai sản | Duyệt đơn, chấm công, BHXH | Chính nhân viên, người duyệt, HR. Quản lý khác trong phạm vi chỉ thấy loại nghỉ (BR-067) | `retention_years` năm sau nghỉ việc (BR-141) |
| Lương, phụ cấp, phiếu lương, bảng lương | Trả lương | HR; chính nhân viên, chỉ phiếu đã chốt (BR-122) | `retention_years` năm sau nghỉ việc; số liệu tổng hợp giữ lâu hơn (BR-141) |
| Mã số thuế, mã số BHXH, cam kết thu nhập | Khấu trừ thuế, đóng bảo hiểm | HR; chính nhân viên | `retention_years` năm sau nghỉ việc (BR-141) |
| Người phụ thuộc: họ tên, ngày sinh, số định danh, quan hệ | Giảm trừ gia cảnh | HR; chính nhân viên | `retention_years` năm sau nghỉ việc (BR-141) |
| File báo cáo xuất ra | Trình ký, lưu trữ | Người xuất; nằm ngoài hệ thống sau khi tải về, nên chỉ ghi nhật ký được (BR-136) | Ngoài kiểm soát của hệ thống |

## Edge cases

| ID | Situation | Expected handling | Rule | Verified by |
|---|---|---|---|---|
| EC-001 | Tiếp nhận nhân viên có ngày vào làm ở tương lai | Hồ sơ ở trạng thái Sắp vào làm, không hiện trong danh bạ. Tài khoản tạo được nhưng chỉ đăng nhập được từ ngày vào làm | BR-032 | — |
| EC-002 | Ghi nhận hai thay đổi công tác cùng ngày hiệu lực | Từ chối thay đổi thứ hai; HR sửa thay đổi đã có | BR-016 | — |
| EC-003 | Ghi bù một thay đổi công tác vào giữa hai thay đổi đã có | Thay đổi mới chỉ có tác dụng tới ngày trước thay đổi kế tiếp; các thay đổi sau giữ nguyên | BR-017 | — |
| EC-004 | Trưởng phòng ban được chuyển sang phòng ban khác | Bổ nhiệm trưởng không tự kết thúc; hệ thống cảnh báo HR | BR-011 | — |
| EC-005 | Trưởng phòng ban nghỉ việc | Bổ nhiệm kết thúc ở ngày làm việc cuối cùng. Quản lý trực tiếp của nhân viên trong phòng ban chuyển lên phòng ban cha gần nhất có trưởng | BR-012, BR-019 | — |
| EC-006 | Chuyển một phòng ban sang nhánh khác | Từ ngày hiệu lực, nhân viên trong nhánh đó có quản lý gián tiếp mới; quản lý cũ không còn thấy nhánh đó | BR-012, BR-013 | — |
| EC-007 | Giải thể phòng ban còn nhân viên | Từ chối và liệt kê nhân viên cần chuyển đi | BR-010 | — |
| EC-008 | Nhân viên đã nghỉ việc được tuyển lại | HR tuyển lại trên hồ sơ cũ, giữ mã nhân viên; không tạo hồ sơ mới | BR-015, BR-022, BR-139 | — |
| EC-009 | Ghi nhận nghỉ việc khi còn thay đổi công tác có hiệu lực sau ngày làm việc cuối cùng | Từ chối và liệt kê thay đổi cần hủy | BR-019 | — |
| EC-010 | HR thu hồi vai trò HR của chính mình | Cho phép khi còn HR khác đang hoạt động; từ chối khi là HR cuối cùng | BR-004 | — |
| EC-011 | Phòng ban gốc không có trưởng | Nhân viên không tìm được trưởng nào ở các cấp trên thì không có quản lý trực tiếp; đơn nghỉ của người đó do HR duyệt | BR-012, BR-056 | — |
| EC-012 | Nhân viên muốn đổi số tài khoản ngân hàng | Chỉ HR sửa được, để kẻ chiếm được tài khoản đăng nhập không đổi được nơi nhận lương | BR-021 | — |
| EC-013 | Xem cơ cấu tại một ngày trước ngày thành lập phòng ban gốc | Hiện cơ cấu trống kèm thông báo | BR-009 | — |
| EC-014 | Hợp đồng mới bắt đầu trước khi hợp đồng cũ kết thúc | Từ chối; HR sửa ngày kết thúc của hợp đồng cũ trước | BR-025 | — |
| EC-015 | Đăng nhập khi tài khoản đang bị khóa tạm | Từ chối với thông báo thử lại sau; không cho biết mật khẩu vừa nhập đúng hay sai | BR-003 | — |
| EC-016 | Hai HR cùng sửa một hồ sơ | Người lưu sau được báo hồ sơ đã thay đổi; không ghi đè ngầm | BR-030 | — |
| EC-017 | Tiếp nhận nhân viên khi chưa có hợp đồng | Cho lưu; hồ sơ hiện cảnh báo chưa có hợp đồng cho HR | — | — |
| EC-018 | Số CCCD trùng với một hồ sơ đã có | Từ chối và dẫn tới hồ sơ đó | BR-022 | — |
| EC-019 | Tìm tên không dấu hoặc khác hoa thường | Vẫn tìm thấy; ví dụ "nguyen van a" khớp "Nguyễn Văn A" | — | — |
| EC-020 | File nhập nhân viên có dòng lỗi | Không lưu dòng nào; hiện từng dòng lỗi kèm lý do | BR-015, BR-016, BR-022 | — |
| EC-021 | Nhân viên là trưởng của chính phòng ban mình thuộc | Quản lý trực tiếp là trưởng của phòng ban cha gần nhất có trưởng khác người đó | BR-012 | — |
| EC-022 | Đã ghi thay đổi chuyển nhân viên vào phòng ban P cho tương lai, rồi HR giải thể P trước ngày đó | Từ chối giải thể, vì từ ngày hiệu lực P vẫn còn nhân viên | BR-010, BR-014 | — |
| EC-023 | Đơn phép năm trải qua hai năm, ví dụ 29/12 tới 2/1 | Phần ngày của mỗi năm trừ vào phép của năm đó | BR-052 | — |
| EC-024 | Hai đơn phép năm của cùng nhân viên được gửi hoặc duyệt cùng lúc, tổng số ngày vượt số phép | Chỉ một đơn được chấp nhận; đơn kia bị từ chối vì thiếu phép. Số phép không bao giờ âm vì lý do này | BR-053 | — |
| EC-025 | Đơn chỉ gồm ngày cuối tuần hoặc ngày nghỉ lễ | Từ chối vì số ngày bằng 0 | BR-044 | — |
| EC-026 | Có ngày nghỉ lễ nằm giữa khoảng nghỉ | Ngày nghỉ lễ không được tính vào số ngày | BR-044 | — |
| EC-027 | Quản lý trực tiếp chuyển phòng ban khi đơn còn đang chờ | Đơn chuyển cho người duyệt mới và người đó được thông báo | BR-057 | — |
| EC-028 | Nhân viên nghỉ việc khi còn đơn có ngày sau ngày làm việc cuối cùng | Các đơn đó bị hủy khi việc nghỉ có hiệu lực; phép năm được hoàn; nhân viên được thông báo | BR-065 | — |
| EC-029 | Đơn đang chờ mà đã qua ngày bắt đầu | Vẫn duyệt hoặc từ chối được; đơn được đánh dấu quá hạn cho người duyệt và HR | — | — |
| EC-030 | Số phép giảm sau khi gửi đơn, do HR điều chỉnh hoặc đơn khác được duyệt, nên không còn đủ cho đơn đang chờ | Thao tác duyệt bị từ chối kèm thông báo thiếu phép; đơn vẫn chờ để nhân viên hủy hoặc người duyệt từ chối | BR-053 | — |
| EC-031 | HR thêm ngày nghỉ lễ trùng một đơn đã duyệt chưa bắt đầu | Số ngày của đơn giảm; phép năm được hoàn; nhân viên được thông báo | BR-064 | — |
| EC-032 | HR thêm ngày làm bù làm tăng số ngày của một đơn phép năm đã duyệt, và nhân viên không đủ phép cho phần tăng | Đơn giữ nguyên trạng thái; số phép tạm âm; HR thấy cảnh báo kèm danh sách đơn cần xử lý. Đây là trường hợp duy nhất số phép được âm | BR-064 | — |
| EC-033 | Đơn đã duyệt có ngày nghỉ sau hạn phép tồn | Phần ngày sau hạn đã được trừ vào phép năm mới ngay lúc duyệt, nên khi phép tồn hết hạn không có gì thay đổi | BR-052 | — |
| EC-034 | Nhân viên vào làm giữa tháng | Tháng đó chỉ được cộng phép khi đủ tỷ lệ ngày làm việc | BR-050 | — |
| EC-035 | Người gửi đơn là HR duy nhất và không có quản lý trực tiếp, nên không có ai khác để duyệt | Đơn được tự duyệt và nhật ký ghi rõ là tự duyệt | BR-060 | — |
| EC-036 | Nhân viên muốn sửa đơn đang chờ duyệt | Không có thao tác sửa; nhân viên hủy rồi gửi đơn mới | BR-061 | — |
| EC-037 | HR đổi phép năm cơ bản của nhân viên giữa năm, ví dụ từ 12 lên 14 ngày | Các tháng đã cộng giữ nguyên; từ tháng kế tiếp cộng theo mức mới | BR-048 | — |
| EC-038 | Lần cộng phép hằng tháng không chạy được đúng ngày, hoặc chạy hai lần | Lần chạy sau cộng bù các tháng còn thiếu; tháng đã cộng không được cộng lại | BR-049 | — |
| EC-039 | Ca qua nửa đêm, ví dụ 22:00–06:00 | Lượt chấm sau nửa đêm thuộc ngày bắt đầu ca | BR-074 | — |
| EC-040 | Ngày làm việc chỉ có một lượt chấm | Ngày ở trạng thái Thiếu chấm công cho tới khi có giải trình được duyệt hoặc HR xử lý | BR-077 | — |
| EC-041 | HR nhập cùng một file chấm công hai lần | Lần thứ hai không tạo lượt chấm mới | BR-073 | — |
| EC-042 | File có mã chấm công không khớp nhân viên nào | Dòng đó bị bỏ qua và có trong danh sách bỏ qua | BR-073 | — |
| EC-043 | Nhân viên đổi ca giữa tháng | Mỗi ngày tính theo ca có hiệu lực tại ngày đó | BR-070 | — |
| EC-044 | Nghỉ phép buổi sáng, đi làm buổi chiều | Nửa ngày nghỉ theo loại nghỉ và nửa công; đi muộn tính so với giờ bắt đầu buổi chiều | BR-076 | — |
| EC-045 | Chấm công vào ngày nghỉ lễ hoặc cuối tuần mà không có đơn làm thêm | Không tạo công hay giờ làm thêm; ngày được đánh dấu cho HR | BR-079 | — |
| EC-046 | Có đơn nghỉ cả ngày đã duyệt nhưng vẫn có lượt chấm | Giữ ngày nghỉ theo đơn; ngày được đánh dấu cho HR | BR-080 | — |
| EC-047 | Đơn làm thêm được duyệt 18:00–21:00 nhưng giờ ra là 20:00 | Giờ làm thêm thực tế là 2 giờ | BR-085 | — |
| EC-048 | Làm thêm kéo dài qua 22:00 | Phần sau 22:00 là giờ làm thêm ban đêm | BR-071, BR-085 | — |
| EC-049 | Làm thêm vào ngày nghỉ lễ | Giờ làm thêm thuộc loại ngày nghỉ lễ | BR-085 | — |
| EC-050 | Đơn làm thêm làm tổng giờ của tháng vượt giới hạn | Từ chối và hiện số giờ còn được làm trong tháng | BR-084 | — |
| EC-051 | Nhân viên gửi đơn làm thêm sau giờ bắt đầu | Từ chối | BR-083 | — |
| EC-052 | Nhân viên hủy đơn nghỉ đã duyệt có ngày thuộc tháng đã chốt | Từ chối | BR-090 | — |
| EC-053 | HR ghi thay đổi công tác hoặc đổi ca có hiệu lực trong tháng đã chốt | Thay đổi được lưu; bảng công đã chốt không đổi; HR được cảnh báo | BR-090 | — |
| EC-054 | HR thêm ngày nghỉ lễ vào tháng đã chốt | Từ chối | BR-090 | — |
| EC-055 | Nhân viên vào làm hoặc nghỉ việc giữa tháng | Bảng công chỉ gồm các ngày trong khoảng làm việc | BR-092 | — |
| EC-056 | HR mở lại bảng công khi bảng lương của tháng đó đã chốt | Từ chối | BR-091 | — |
| EC-057 | Nhân viên đi muộn 4 giờ mà không có đơn | Ngày vẫn đủ công theo lựa chọn của chủ dự án; ngày bị đánh dấu bất thường để quản lý xử lý theo quy chế kỷ luật | BR-075, BR-078 | — |
| EC-058 | Ngày đã có giờ vào và giờ ra nhưng máy ghi sai giờ | Nhân viên gửi giải trình; khi được duyệt, giờ đề nghị thay giờ từ máy | BR-081 | — |
| EC-059 | Nhân viên được tăng lương từ ngày 15 | Tháng đó tính thành hai đoạn theo hai bản ghi lương, mỗi đoạn theo công hưởng lương trong đoạn | BR-105, BR-106 | — |
| EC-060 | Nhân viên vào làm ngày 20 của tháng | Lương theo công chỉ gồm các ngày từ 20; phụ cấp cố định giảm theo số ngày làm việc trong khoảng làm việc; không đóng bảo hiểm nếu số ngày không làm từ `insurance_skip_unpaid_days` trở lên | BR-101, BR-105, BR-106 | — |
| EC-061 | Nhân viên nghỉ không lương cả tháng | Lương và phụ cấp bằng 0; không đóng bảo hiểm; thực lĩnh 0 nếu không có khoản điều chỉnh | BR-101, BR-104 | — |
| EC-062 | Khoản tạm ứng lớn hơn thu nhập của tháng | Thực lĩnh âm nên không chốt được; HR giảm khoản trừ ở tháng này và thêm phần còn lại vào tháng sau | BR-117 | — |
| EC-063 | Tăng lương có hiệu lực từ một tháng đã chốt lương | Bảng lương đã chốt không đổi; hệ thống hiện chênh lệch từng tháng để HR thêm khoản truy lĩnh vào bảng lương chưa chốt | BR-098, BR-118 | — |
| EC-064 | HR mở lại bảng công khi bảng lương của tháng đang Nháp | Bảng lương chuyển sang Cần tính lại; tính lại chỉ được sau khi bảng công chốt lại | BR-102, BR-119 | — |
| EC-065 | Lương đóng bảo hiểm cao hơn trần | Mức đóng bị chặn ở trần của từng loại bảo hiểm | BR-110 | — |
| EC-066 | Lương đóng bảo hiểm thấp hơn lương tối thiểu vùng | Từ chối lưu bản ghi lương | BR-096 | — |
| EC-067 | Hai nhân viên, ví dụ vợ và chồng cùng làm ở công ty, cùng khai một con là người phụ thuộc | Từ chối người khai sau trong các tháng chung | BR-099 | — |
| EC-068 | Thu nhập chịu thuế thấp hơn tổng bảo hiểm và giảm trừ | Thu nhập tính thuế là 0; thuế là 0 | BR-112 | — |
| EC-069 | Nhân viên thử việc có thu nhập chịu thuế trong tháng 5.000.000 đồng và chưa có cam kết thu nhập | Khấu trừ 10%, tức 500.000 đồng | BR-113 | — |
| EC-070 | Biểu thuế mới có hiệu lực từ 01/07/2026 | Bảng lương tháng 6 dùng biểu cũ; tháng 7 dùng biểu mới | BR-123 | — |
| EC-071 | Nhân viên nghỉ việc ngày 10/05 và còn 3,5 ngày phép chưa nghỉ | Phiếu lương tháng 5 có lương theo công tới 10/05 và tiền 3,5 ngày phép | BR-120, BR-121 | — |
| EC-072 | Hai HR cùng chốt, hoặc một người tính lại trong lúc người kia chốt | Chỉ một thao tác thành công; bảng lương đã chốt khớp đúng một lần tính | BR-117 | — |
| EC-073 | Nhân viên chưa có số tài khoản ngân hàng | Cảnh báo khi chốt nhưng vẫn chốt được; người đó không có trong danh sách chuyển khoản | BR-126 | — |
| EC-074 | Làm thêm sau 22:00 vào ngày làm việc | Phần sau 22:00 có hệ số 210% với giá trị tham số ban đầu | BR-108 | — |
| EC-075 | Nhân viên đổi sang ca có giờ làm chuẩn khác giữa tháng | Đơn giá giờ của mỗi ngày tính theo ca tại ngày đó | BR-107 | — |
| EC-076 | Nhân viên có ngày làm việc trong tháng nhưng không có bản ghi lương | Phiếu của người đó có lỗi; bảng lương không chốt được tới khi HR ghi lương và tính lại | BR-117 | — |
| EC-077 | HR sửa tỷ lệ bảo hiểm đã được dùng trong bảng lương đã chốt | Từ chối; HR thêm giá trị mới với ngày hiệu lực mới | BR-123 | — |
| EC-078 | Quản lý xem chi phí lương khi một phòng ban con có 2 người | Số liệu của phòng đó được gộp vào phòng ban cha gần nhất | BR-129 | — |
| EC-079 | Phạm vi của Quản lý chỉ có 2 người | Báo cáo chi phí lương không hiện số liệu và ghi lý do | BR-129 | — |
| EC-080 | Nhân viên chuyển phòng ban giữa tháng | Chi phí lương cả tháng tính cho phòng ban tại ngày cuối tháng mà người đó còn làm | BR-127, BR-131 | — |
| EC-081 | Nhân viên vào làm và nghỉ việc trong cùng một kỳ | Được tính ở cả vào mới và nghỉ việc; không có trong đầu kỳ và cuối kỳ | BR-132 | — |
| EC-082 | Hồ sơ bị hủy tiếp nhận | Không có trong báo cáo nào | BR-132 | — |
| EC-083 | Truy lĩnh lương tháng 3 được trả trong bảng lương tháng 5 | Tính vào chi phí lương tháng 5 | BR-131 | — |
| EC-084 | Quản lý xem kỳ trước khi phạm vi của mình đã đổi | Dùng phạm vi tại ngày cuối của kỳ báo cáo | BR-127 | — |
| EC-085 | Tháng chưa chốt lương | Quản lý không thấy tháng đó; HR thấy kèm nhãn tạm tính | BR-130 | — |
| EC-086 | Quản lý mở báo cáo của phòng ban ngoài phạm vi bằng đường dẫn trực tiếp | Từ chối | BR-127 | — |
| EC-087 | HR ghi ngày làm việc cuối cùng trước ngày vào làm của khoảng làm việc hiện tại | Từ chối | BR-019 | — |
| EC-088 | File chấm công thiếu cột bắt buộc hoặc không đọc được | Từ chối cả file, không lưu dòng nào, chỉ ra cột thiếu | BR-073 | — |
| EC-089 | HR ghi bản ghi lương trùng ngày hiệu lực với bản ghi đã có | Từ chối; HR sửa bản ghi đã có | BR-093 | — |
| EC-090 | Người có hồ sơ đã bị ẩn danh xin vào làm lại | Không tuyển lại được vì hồ sơ không còn thông tin; HR tiếp nhận như người mới với mã mới | BR-139, BR-141 | — |
| EC-091 | Nhân viên được tuyển lại trước khi tới hạn xóa thông tin liên hệ | Không còn trong danh sách cần xóa; hạn được tính lại từ lần nghỉ việc sau | BR-140 | — |
