# Requirements: hr-manager

- **Status:** Accepted
- **Updated:** 2026-10-31
- **Reviewed:** 2026-10-30: chủ dự án review từng phần qua PR #17 tới #22; agent chạy Analysis checklist. Chưa có
  người ngoài review
- **Related:** [brief](../project/brief.md) · [stories](stories.md) · [domain](domain.md) · [ui-flow](ui-flow.md) · [SPEC](../build/SPEC.md) ·
  [analysis guide](../playbook/analysis.md)

## Goal

Baseline mô tả đủ hành vi của sáu milestone M1–M6 trong [brief](../project/brief.md#scope) để thiết kế toàn hệ thống trước khi
code. Tài liệu được điền theo từng milestone và đã đủ phần dùng chung cùng M1 tới M5; phần của M6 thêm khi phân tích
AI. Bản phát hành đầu tiên là v1.0, gồm mọi story của M1 tới M6 trong [stories](stories.md#summary).

## Actors

Hệ thống có ba vai trò người. Một người có thể giữ nhiều vai trò, ví dụ trưởng phòng vừa là Nhân viên vừa là Quản lý.
Ban giám đốc không có vai trò riêng: giám đốc là trưởng phòng ban gốc nên dùng vai trò Quản lý với phạm vi toàn công ty.

| Actor | Type | Goals | Permissions |
|---|---|---|---|
| Nhân viên | Người | Xem và cập nhật thông tin của mình; tra cứu đồng nghiệp | Mọi người có tài khoản đang hoạt động đều có vai trò này (BR-006) |
| Quản lý | Người | Nắm thông tin nhân sự trong phạm vi mình phụ trách; từ M2, duyệt yêu cầu của nhân viên trong phạm vi; từ M5, xem báo cáo của phạm vi | Tự có khi đang là trưởng của ít nhất một phòng ban, không gán tay (BR-006). Phạm vi gồm phòng ban mình làm trưởng và mọi phòng ban con (BR-013) |
| HR | Người | Giữ hồ sơ, hợp đồng và cơ cấu tổ chức đúng; quản lý tài khoản và cấu hình; từ M4, tính và chốt lương | Được gán tay (BR-006). HR kiêm quản trị hệ thống và tính lương; hệ thống không có vai trò Kế toán |
| Thời gian | Lịch | Làm cho thay đổi có ngày hiệu lực tự có tác dụng khi tới ngày | Chỉ thực hiện các chuyển trạng thái do thời gian trong mục Lifecycles của [domain](domain.md#lifecycles) |
| Máy chấm công | Hệ thống ngoài | Cung cấp lượt chấm công của nhân viên qua file do HR xuất ra và tải lên | Hệ thống không kết nối trực tiếp với máy |

AI Leave Coordinator và các tính năng AI khác của M6 là một phần của hệ thống, không phải actor. AI không có cột riêng
trong ma trận dưới: AI làm việc theo ba tầng ở BR-155 tới BR-158, và đầu ra không bao giờ rộng hơn quyền của người nhận
(BR-160).

### Permission matrix

"Phạm vi" là nhân viên trong phạm vi của Quản lý theo BR-013. Quyền được kiểm ở backend, kể cả khi giao diện đã ẩn nút.
Các story do Thời gian thực hiện (US-030, US-031, US-040) không có dòng riêng: không người dùng nào gọi trực tiếp.

| Operation | Nhân viên | Quản lý | HR |
|---|---|---|---|
| Đăng nhập, đổi mật khẩu của mình (US-001) | ✅ | ✅ | ✅ |
| Xem hồ sơ, quá trình công tác và hợp đồng của mình (US-017) | ✅ | ✅ | ✅ |
| Sửa thông tin liên hệ của mình (US-017) | ✅ | ✅ | ✅ |
| Tra cứu danh bạ (US-019) | ✅ | ✅ | ✅ |
| Xem sơ đồ tổ chức hiện tại (US-009) | ✅ | ✅ | ✅ |
| Xem thông tin công việc và quá trình công tác của người khác (US-018, US-020) | ❌ | ✅ phạm vi | ✅ mọi người |
| Xem thông tin cá nhân và hợp đồng của người khác (US-012, US-015) | ❌ | ❌ | ✅ |
| Tiếp nhận nhân viên mới; sửa hồ sơ (US-011, US-012) | ❌ | ❌ | ✅ |
| Nhập nhân viên từ bảng tính (US-021) | ❌ | ❌ | ✅ |
| Ghi nhận thay đổi công tác, nghỉ việc (US-013, US-014) | ❌ | ❌ | ✅ |
| Quản lý hợp đồng; xem hợp đồng sắp hết hạn (US-015, US-016) | ❌ | ❌ | ✅ |
| Quản lý chức danh, phòng ban, trưởng phòng ban (US-005 tới US-008) | ❌ | ❌ | ✅ |
| Xem cơ cấu tổ chức tại một ngày khác hôm nay (US-010) | ❌ | ❌ | ✅ |
| Quản lý tài khoản; gán và thu hồi vai trò HR (US-002, US-003) | ❌ | ❌ | ✅ |
| Xem nhật ký thao tác (US-004) | ❌ | ❌ | ✅ |
| Tuyển lại nhân viên đã nghỉ việc (US-071) | ❌ | ❌ | ✅ |
| Xóa và ẩn danh dữ liệu hết hạn lưu (US-072) | ❌ | ❌ | ✅ |
| Xem số dư phép và biến động phép của mình (US-022) | ✅ | ✅ | ✅ |
| Nhận thông báo về đơn của mình và đơn mình là người duyệt (US-034) | ✅ | ✅ | ✅ |
| Gửi đơn nghỉ, hủy đơn nghỉ của mình (US-023, US-024) | ✅ | ✅ | ✅ |
| Duyệt, từ chối đơn nghỉ (US-025, US-026) | ❌ | ✅ chỉ đơn mình là người duyệt | ✅ mọi đơn, duyệt thay |
| Xem đơn, số dư phép và lịch nghỉ của người khác (US-027) | ❌ | ✅ phạm vi; lý do nghỉ chỉ khi là người duyệt | ✅ mọi người |
| Quản lý loại nghỉ và lịch làm việc (US-028, US-029) | ❌ | ❌ | ✅ |
| Điều chỉnh số dư phép; ghi đơn nghỉ thay nhân viên (US-032, US-033) | ❌ | ❌ | ✅ |
| Xem số phép chưa nghỉ của nhân viên nghỉ việc (US-035) | ❌ | ❌ | ✅ |
| Xem bảng công của mình; gửi giải trình chấm công; đăng ký và hủy đơn làm thêm giờ của mình (US-041, US-042, US-044) | ✅ | ✅ | ✅ |
| Duyệt, từ chối giải trình chấm công và đơn làm thêm giờ (US-043, US-045) | ❌ | ✅ chỉ đơn mình là người duyệt | ✅ mọi đơn, duyệt thay |
| Xem bảng công của người khác (US-046) | ❌ | ✅ phạm vi | ✅ mọi người |
| Quản lý ca, gán ca, khai báo mã chấm công (US-036 tới US-038) | ❌ | ❌ | ✅ |
| Nhập file chấm công; xử lý ngày thiếu chấm công (US-039, US-047) | ❌ | ❌ | ✅ |
| Chốt, mở lại và xuất bảng công (US-048, US-049) | ❌ | ❌ | ✅ |
| Xem phiếu lương đã chốt của mình (US-061) | ✅ | ✅ | ✅ |
| Xem lương, phụ cấp, thông tin thuế, bảo hiểm và người phụ thuộc của người khác (US-051 tới US-053) | ❌ | ❌ kể cả trong phạm vi (BR-122) | ✅ |
| Ghi lương, thông tin thuế, bảo hiểm và người phụ thuộc (US-051 tới US-053) | ❌ | ❌ | ✅ |
| Quản lý loại phụ cấp và tham số lương (US-050, US-054) | ❌ | ❌ | ✅ |
| Tính, điều chỉnh, chốt và xuất bảng lương (US-055 tới US-060, US-062, US-063) | ❌ | ❌ | ✅ |
| Xem trang tổng quan và báo cáo nhân sự, nghỉ phép, chấm công; xuất báo cáo (US-064 tới US-068, US-070) | ❌ | ✅ phạm vi (BR-127) | ✅ mọi người |
| Xem báo cáo chi phí lương (US-069) | ❌ | ✅ phạm vi, chỉ số tổng hợp từ bảng lương đã chốt (BR-128, BR-129) | ✅ mọi người, kể cả bảng lương Nháp |
| Quản lý danh mục lý do nghỉ, giai đoạn hạn chế nghỉ, ngưỡng nhân sự của phòng ban (US-073, US-075, US-076) | ❌ | ❌ | ✅ |
| Thấy cảnh báo phòng ban thiếu người khi gửi đơn (US-075) | ✅ không kèm tên hay số người (BR-146) | ✅ phạm vi, kèm tên | ✅ mọi người, kèm tên |
| Đề nghị đổi ngày cho đơn đang chờ (US-079) | ❌ | ✅ đơn mình là người duyệt hoặc người duyệt thay | ✅ mọi đơn |
| Phản hồi đề nghị đổi ngày, đổi đơn, gửi nhiều đơn một lần, chọn người nhận bàn giao (US-079 tới US-081) | ✅ đơn của mình | ✅ đơn của mình | ✅ đơn của mình |
| Duyệt khi là người duyệt thay (US-078) | ❌ | ✅ đơn được giao thêm (BR-149) | ✅ |
| Dùng AI tạo đơn; nhận phương án, giải thích và gợi ý của AI cho đơn của mình (US-082 tới US-086) | ✅ | ✅ | ✅ |
| Xem tóm tắt tác động của AI; nhờ AI soạn lý do từ chối hay lời đề nghị (US-088, US-089) | ❌ | ✅ đơn mình là người duyệt hoặc người duyệt thay | ✅ mọi đơn |
| Nhận tổng hợp đơn trong giai đoạn hạn chế (US-087) | ❌ | ✅ phạm vi | ✅ mọi người |
| Nhận đề xuất xử lý đơn làm số phép âm (US-085) | ❌ | ❌ | ✅ |
| Xem thẻ cảnh báo và chi tiết tín hiệu; nhận thông báo và tóm tắt tuần; đánh giá, đóng, tắt và theo dõi thẻ (US-090 tới US-095) | ❌ | ✅ phạm vi, theo cột Viewers của loại tín hiệu (BR-174) | ✅ mọi người |
| Xem tỷ lệ đánh giá hữu ích theo loại tín hiệu (US-093) | ❌ | ❌ | ✅ không thấy đánh giá của từng người (BR-178) |
| Xem insight, cập nhật và tóm tắt tuần do AI viết (US-096, US-097, US-099, US-100) | ❌ | ✅ phạm vi; chỉ chỉ số và chiều thấy được trong báo cáo (BR-183) | ✅ mọi người |
| Gửi thẻ nhắc nhóm từ insight (US-098) | ❌ | ✅ người nhận trong phạm vi (BR-190) | ✅ mọi người |

## User stories

Story và acceptance criteria nằm ở [stories.md](stories.md).

## Use cases

Sơ đồ tổng thể của baseline. Quản lý và HR cũng là Nhân viên nên dùng được mọi use case của Nhân viên; sơ đồ không vẽ
lại các đường đó.

```mermaid
flowchart LR
  NV["Nhân viên"]
  QL["Quản lý"]
  HR["HR"]
  subgraph SYS["hr-manager"]
    U1(["Đăng nhập, đổi mật khẩu"])
    U2(["Xem, cập nhật hồ sơ của mình"])
    U3(["Tra cứu danh bạ, sơ đồ tổ chức"])
    U4(["Xem hồ sơ nhân viên trong phạm vi"])
    U5(["Quản lý hồ sơ, công tác, hợp đồng"])
    U6(["Quản lý cơ cấu tổ chức"])
    U7(["Quản lý tài khoản, vai trò"])
    L1(["M2: Gửi, đổi đơn nghỉ, xem số dư phép"])
    L2(["M2: Duyệt đơn nghỉ, đề nghị đổi ngày"])
    L3(["M2: Cấu hình loại nghỉ, lý do nghỉ, ngày lễ, ngưỡng nhân sự"])
    I1(["M6: Tạo đơn, nhận phương án với AI"])
    I2(["M6: Nhận hỗ trợ duyệt của AI"])
    A1(["M3: Xem bảng công, giải trình, đăng ký làm thêm"])
    A2(["M3: Nhập chấm công, quản lý ca, chốt bảng công"])
    A3(["M3: Duyệt giải trình, làm thêm"])
    P1(["M4: Xem phiếu lương"])
    P2(["M4: Tính và chốt bảng lương"])
    R1(["M5: Xem báo cáo"])
    R2(["M5: Nhận cảnh báo, theo dõi tín hiệu"])
    I3(["M6: Nhận insight của AI"])
  end
  NV --- U1 & U2 & U3 & L1 & A1 & P1 & I1
  QL --- U4 & L2 & A3 & R1 & R2 & I2 & I3
  HR --- U5 & U6 & U7 & L3 & A2 & P2 & R1 & R2 & I3
```

### UC-001: Tiếp nhận nhân viên mới

- **Actor:** HR · **Stories:** US-011, US-015, US-002
- **Trigger:** Công ty tuyển được người và đã chốt ngày vào làm.
- **Preconditions:** Phòng ban và chức danh dự kiến đã có trên hệ thống.
- **Main flow:**
  1. HR nhập thông tin cá nhân.
  2. HR nhập ngày vào làm, chọn phòng ban và chức danh.
  3. HR nhập hợp đồng đầu tiên: loại, ngày bắt đầu, ngày kết thúc nếu có.
  4. Hệ thống kiểm luật hợp đồng (BR-024, BR-028) và hiện bản tóm tắt.
  5. HR xác nhận. Hệ thống cấp mã nhân viên (BR-015) rồi lưu hồ sơ, quá trình công tác đầu tiên và hợp đồng cùng lúc.
  6. HR chọn tạo tài khoản. Hệ thống tạo tài khoản và hiện mật khẩu tạm đúng một lần (BR-002).
- **Alternative flows:**
  - `3a`. Chưa ký hợp đồng: HR bỏ qua bước 3; hồ sơ được lưu kèm cảnh báo chưa có hợp đồng (EC-017).
  - `6a`. HR chưa muốn tạo tài khoản: bỏ qua bước 6; tạo sau ở màn hình tài khoản.
- **Exceptions:**
  - `4a`. Hợp đồng vi phạm giới hạn của luật: hệ thống từ chối và chỉ ra trường sai; HR sửa ở bước 3 (BR-024, BR-028).
  - `5a`. Số CCCD trùng với một hồ sơ đã có: hệ thống từ chối và dẫn tới hồ sơ đó (BR-022, EC-018). Hồ sơ đó ở trạng
    thái Đã nghỉ việc thì hệ thống dẫn tới thao tác Tuyển lại (BR-139, EC-008).
- **Postconditions:** Thành công thì có hồ sơ, một quá trình công tác bắt đầu từ ngày vào làm, hợp đồng nếu đã nhập và
  tài khoản nếu đã tạo; nhật ký ghi lại thao tác. Thất bại ở bước 5 thì không có dữ liệu nào được lưu.

### UC-002: Ghi nhận thay đổi công tác

- **Actor:** HR; Thời gian · **Stories:** US-013
- **Trigger:** Nhân viên được chuyển phòng ban hoặc đổi chức danh.
- **Preconditions:** Nhân viên đang làm việc hoặc sắp vào làm.
- **Main flow:**
  1. HR mở hồ sơ và chọn ghi nhận thay đổi công tác.
  2. HR chọn ngày hiệu lực, phòng ban mới hoặc chức danh mới, và nhập lý do.
  3. Hệ thống hiện quá trình công tác trước và sau thay đổi, cùng quản lý trực tiếp mới (BR-012).
  4. HR xác nhận. Hệ thống lưu thay đổi (BR-016, BR-017).
- **Alternative flows:**
  - `2a`. Ngày hiệu lực ở tương lai: thay đổi được lưu và tự có tác dụng khi tới ngày.
  - `2b`. Ngày hiệu lực ở quá khứ: lý do là bắt buộc; quá trình mới chỉ kéo dài tới thay đổi kế tiếp đã có (BR-018,
    EC-003).
  - `3a`. Nhân viên đang là trưởng một phòng ban: hệ thống cảnh báo rằng bổ nhiệm trưởng không tự kết thúc (EC-004).
- **Exceptions:**
  - `2c`. Ngày hiệu lực ngoài khoảng làm việc của nhân viên: từ chối (BR-017).
  - `2d`. Đã có thay đổi khác cùng ngày hiệu lực: từ chối (EC-002).
  - `2e`. Phòng ban mới không hoạt động tại ngày hiệu lực hoặc sau đó: từ chối (BR-014).
- **Postconditions:** Các quá trình công tác của nhân viên không chồng, không hở (BR-016); nhật ký ghi người làm, lý do,
  giá trị trước và sau.

### UC-003: Ghi nhận nghỉ việc

- **Actor:** HR; Thời gian · **Stories:** US-014
- **Trigger:** Nhân viên nghỉ việc vì tự nghỉ, hết hợp đồng hoặc bị cho thôi việc.
- **Preconditions:** Nhân viên đang làm việc.
- **Main flow:**
  1. HR nhập ngày làm việc cuối cùng và lý do nghỉ.
  2. Hệ thống liệt kê tác động: quá trình công tác, bổ nhiệm trưởng và hợp đồng đang hiệu lực kết thúc ở ngày đó; tài
     khoản bị khóa từ ngày hôm sau (BR-019).
  3. HR xác nhận. Hệ thống lưu.
  4. Sang ngày sau ngày làm việc cuối cùng, Thời gian chuyển nhân viên sang Đã nghỉ việc và khóa tài khoản (BR-005).
- **Alternative flows:**
  - `2a`. Nhân viên là trưởng phòng ban: hệ thống nhắc HR bổ nhiệm người thay; nếu không, phòng ban không có trưởng từ
    ngày hôm sau (EC-005).
  - `3a`. HR hủy ghi nhận khi ngày làm việc cuối cùng chưa qua: mọi tác động bị bỏ (BR-020).
- **Exceptions:**
  - `1a`. Còn thay đổi công tác có hiệu lực sau ngày làm việc cuối cùng: từ chối và liệt kê thay đổi cần hủy (EC-009).
  - `1b`. Ngày làm việc cuối cùng trước ngày vào làm: từ chối (EC-087).
  - `3b`. Nhân viên là HR đang hoạt động cuối cùng: từ chối (BR-004).
- **Postconditions:** Hồ sơ được giữ, không bị xóa. Từ ngày hôm sau, nhân viên không còn trong danh bạ. Nhật ký ghi lại
  thao tác.

### UC-004: Tái cấu trúc phòng ban

- **Actor:** HR; Thời gian · **Stories:** US-006, US-007, US-008
- **Trigger:** Công ty đổi tên, chuyển nhánh hoặc giải thể một phòng ban.
- **Preconditions:** Phòng ban đang hoạt động.
- **Main flow:**
  1. HR chọn phòng ban, chọn thao tác đổi tên, đổi phòng ban cha hoặc giải thể, và nhập ngày hiệu lực.
  2. Hệ thống hiện cơ cấu trước và sau, cùng danh sách nhân viên đổi quản lý trực tiếp (BR-012).
  3. HR xác nhận. Hệ thống lưu.
- **Alternative flows:**
  - `1a`. Ngày hiệu lực ở tương lai: thay đổi tự có tác dụng khi tới ngày.
- **Exceptions:**
  - `1b`. Phòng ban cha mới là chính phòng ban đó hoặc nằm trong nhánh con của nó: từ chối (BR-008).
  - `1c`. Giải thể khi còn nhân viên hoặc phòng ban con đang hoạt động: từ chối và liệt kê (BR-010, EC-007, EC-022).
  - `1d`. Thao tác khác đổi tên trên phòng ban gốc: từ chối (BR-007).
- **Postconditions:** Cây tổ chức hợp lệ tại mọi ngày; nhật ký ghi lại thao tác.

### UC-005: Gửi và duyệt đơn nghỉ

- **Actor:** Nhân viên; Quản lý, HR · **Stories:** US-023, US-025, US-026, US-034, US-074, US-075, US-077, US-078,
  US-079
- **Trigger:** Nhân viên cần nghỉ.
- **Preconditions:** Nhân viên đang làm việc và có tài khoản.
- **Main flow:**
  1. Nhân viên chọn lý do nghỉ trong danh mục, loại nghỉ hợp lệ của lý do đó (BR-142), ngày và buổi bắt đầu, ngày và
     buổi kết thúc; nhập mô tả thêm khi cần (BR-144).
  2. Hệ thống tính số ngày nghỉ theo lịch làm việc (BR-044). Với phép năm, hệ thống hiện số phép còn lại sau đơn
     (BR-053). Đơn làm phòng ban dưới ngưỡng hoặc thuộc giai đoạn hạn chế thì hiện cảnh báo (BR-146, BR-147).
  3. Nhân viên gửi đơn.
  4. Hệ thống xác định người duyệt (BR-056) và gửi thông báo cho người đó (BR-066).
  5. Người duyệt xem đơn, số dư phép của nhân viên và các đơn khác của nhóm trong cùng khoảng ngày.
  6. Người duyệt duyệt đơn.
  7. Hệ thống kiểm lại số phép, trừ phép nếu là phép năm (BR-053, BR-054) và thông báo cho nhân viên.
- **Alternative flows:**
  - `4a`. Nhân viên không có quản lý trực tiếp: HR là người duyệt (BR-056).
  - `5a`. Người duyệt không còn quản lý nhân viên trước khi duyệt: đơn chuyển cho người duyệt mới (BR-057, EC-027).
  - `5b`. HR duyệt thay người duyệt (BR-058).
  - `5c`. Đơn chờ lâu: người duyệt được nhắc, rồi HR được thông báo (BR-148).
  - `5d`. Người duyệt đang nghỉ: đơn được giao thêm cho người duyệt thay (BR-149).
  - `6a`. Người duyệt từ chối và nhập lý do (BR-059). Số dư không đổi.
  - `6b`. Người duyệt đề nghị đổi ngày; nhân viên chấp nhận, không đồng ý hoặc hủy đơn (BR-150, BR-151).
- **Exceptions:**
  - `2a`. Khoảng nghỉ không có ngày làm việc nào: từ chối (EC-025).
  - `2b`. Đơn chồng buổi với đơn khác đang chờ duyệt hoặc đã duyệt: từ chối (BR-045).
  - `2c`. Thiếu phép năm, vượt số ngày tối đa của loại nghỉ hoặc ra ngoài khoảng làm việc: từ chối (BR-053, BR-047,
    BR-046).
  - `7a`. Tại lúc duyệt, số phép không còn đủ: từ chối thao tác duyệt; đơn vẫn chờ (EC-024, EC-030).
- **Postconditions:** Đơn được duyệt thì có một biến động phép trừ số ngày, nếu là phép năm. Đơn bị từ chối hay bị hủy
  thì số dư không đổi. Mọi bước được ghi nhật ký.

### UC-006: Cộng phép và chuyển phép tồn

- **Actor:** Thời gian · **Stories:** US-030, US-031
- **Trigger:** Tới ngày cuối tháng, ngày 1/1 hoặc ngày sau hạn phép tồn.
- **Preconditions:** Lịch làm việc của tháng hoặc năm liên quan đã có.
- **Main flow:**
  1. Ngày cuối mỗi tháng, hệ thống xác định nhân viên có tháng đủ điều kiện (BR-050).
  2. Hệ thống cộng cho mỗi người 1/12 phép năm cơ bản của họ, ghi thành biến động phép (BR-048, BR-049).
  3. Ngày 1/1, hệ thống chuyển phép năm chưa dùng của năm trước thành phép tồn, tối đa `carryover_max_days` ngày, và hủy
     phần vượt (BR-051).
  4. Ngày sau `carryover_expiry`, hệ thống hủy phép tồn còn lại.
- **Alternative flows:**
  - `1a`. Nhân viên vào làm hoặc nghỉ việc trong tháng: tháng đó chỉ được tính khi đủ tỷ lệ ngày làm việc (BR-050,
    EC-034).
- **Exceptions:**
  - `1b`. Hệ thống không chạy được đúng ngày: lần chạy sau cộng bù các tháng còn thiếu và không cộng trùng (EC-038).
- **Postconditions:** Mỗi tháng đủ điều kiện của mỗi nhân viên được cộng đúng một lần. Số dư phép luôn bằng tổng các biến
  động phép.

### UC-007: Nhập file chấm công và tính công

- **Actor:** HR; Máy chấm công, Thời gian · **Stories:** US-039, US-040
- **Trigger:** HR xuất file từ máy chấm công, thường mỗi tuần một lần.
- **Preconditions:** Nhân viên đã có mã chấm công và ca làm việc.
- **Main flow:**
  1. HR tải file lên.
  2. Hệ thống đọc từng dòng, ghép mã chấm công với nhân viên và bỏ qua lượt chấm trùng (BR-073).
  3. Hệ thống hiện số dòng sẽ lưu, số dòng trùng, và từng dòng bị bỏ qua kèm lý do.
  4. HR xác nhận. Hệ thống lưu lượt chấm.
  5. Hệ thống tính lại công cho các ngày có lượt chấm mới: giờ vào, giờ ra, đi muộn, về sớm, giờ làm thêm (BR-074 tới
     BR-080, BR-085).
- **Alternative flows:**
  - `3a`. HR hủy sau khi xem kết quả: không lượt chấm nào được lưu.
- **Exceptions:**
  - `2a`. File sai định dạng: từ chối cả file và chỉ ra cột thiếu (EC-088).
  - `2b`. Dòng thuộc tháng đã chốt: bỏ qua và liệt kê (BR-090).
- **Postconditions:** Nhập lại cùng một file không tạo lượt chấm trùng (EC-041). Nhật ký ghi người nhập, file và số dòng.

### UC-008: Đăng ký và duyệt làm thêm giờ

- **Actor:** Nhân viên; Quản lý, HR · **Stories:** US-044, US-045
- **Trigger:** Nhân viên cần làm thêm ngoài giờ ca.
- **Preconditions:** Nhân viên đang làm việc; tháng của ngày làm thêm chưa chốt.
- **Main flow:**
  1. Nhân viên nhập ngày, giờ bắt đầu, giờ kết thúc và lý do, trước giờ bắt đầu (BR-083).
  2. Hệ thống kiểm khoảng làm thêm nằm ngoài giờ ca và không chồng đơn khác (BR-086), rồi kiểm giới hạn giờ làm thêm theo
     ngày, tháng và năm (BR-084).
  3. Hệ thống gửi đơn cho người duyệt theo cùng luật với đơn nghỉ (BR-056) và thông báo.
  4. Người duyệt duyệt đơn.
  5. Sau khi có chấm công, hệ thống tính giờ làm thêm thực tế bằng phần giao giữa khoảng đã duyệt và khoảng có mặt, rồi
     phân loại theo ngày và ban đêm (BR-085).
- **Alternative flows:**
  - `4a`. Người duyệt từ chối kèm lý do (BR-059).
  - `4b`. HR duyệt thay (BR-058).
- **Exceptions:**
  - `1a`. Gửi sau giờ bắt đầu: từ chối (EC-051).
  - `2a`. Vượt giới hạn giờ làm thêm: từ chối và hiện số giờ còn được làm (BR-084, EC-050).
  - `5a`. Không có chấm công trong khoảng đã duyệt: giờ làm thêm thực tế bằng 0; nhân viên gửi giải trình nếu quên chấm
    (BR-081, BR-085).
- **Postconditions:** Chỉ giờ làm thêm đã duyệt và có mặt mới vào bảng công. Nhật ký ghi mọi bước.

### UC-009: Chốt bảng công tháng

- **Actor:** HR · **Stories:** US-047, US-048
- **Trigger:** Hết tháng, trước khi tính lương.
- **Preconditions:** Đã nhập đủ file chấm công của tháng.
- **Main flow:**
  1. HR chọn tháng cần chốt.
  2. Hệ thống liệt kê việc còn chặn: đơn nghỉ, đơn làm thêm, giải trình đang chờ duyệt; ngày thiếu chấm công hoặc vắng
     chưa xử lý (BR-089).
  3. HR xử lý từng việc: nhắc người duyệt, duyệt thay, hoặc ghi công trực tiếp cho ngày thiếu chấm công (BR-082).
  4. Khi không còn việc chặn, HR chốt. Hệ thống chụp lại bảng công tháng của mọi nhân viên (BR-092).
- **Alternative flows:**
  - `4a`. Cần sửa sau khi chốt: HR mở lại kèm lý do nếu bảng lương tháng đó chưa chốt (BR-091), sửa, rồi chốt lại.
- **Exceptions:**
  - `4b`. Còn việc chặn: không chốt được (BR-089).
- **Postconditions:** Tháng đã chốt không nhận thay đổi về đơn, lượt chấm hay lịch làm việc (BR-090). Bảng công đã chốt
  là đầu vào của bảng lương ở M4.

### UC-010: Tính và chốt bảng lương tháng

- **Actor:** HR · **Stories:** US-055 tới US-060, US-062
- **Trigger:** Bảng công tháng đã chốt, tới ngày tính lương.
- **Preconditions:** Bảng công của tháng đã chốt (BR-102); tham số lương có giá trị hiệu lực cho tháng đó (BR-123).
- **Main flow:**
  1. HR chọn tháng và bấm Tính lương.
  2. Hệ thống tạo phiếu lương cho mỗi nhân viên có ngày làm việc trong tháng: lương theo công, phụ cấp, tiền làm thêm và
     làm đêm, bảo hiểm, thuế TNCN, thực lĩnh (BR-103 tới BR-114).
  3. Hệ thống hiện bảng lương ở trạng thái Nháp, kèm danh sách lỗi và cảnh báo, như thiếu bản ghi lương hay thiếu số tài
     khoản ngân hàng.
  4. HR thêm khoản điều chỉnh vào từng phiếu nếu cần: thưởng, tạm ứng, truy lĩnh, truy thu (BR-115). Hệ thống tính lại
     thuế và thực lĩnh của phiếu đó.
  5. HR kiểm bảng lương rồi bấm Chốt.
  6. Hệ thống chốt bảng lương, công bố phiếu lương và thông báo cho nhân viên (BR-117, BR-125).
- **Alternative flows:**
  - `2a`. Nhân viên có ngày làm việc cuối cùng trong tháng: phiếu có thêm tiền phép chưa nghỉ (BR-120, BR-121).
  - `4a`. Dữ liệu nguồn đổi sau khi tính, như HR sửa lương hay mở lại bảng công: bảng lương được đánh dấu Cần tính lại;
    HR tính lại, khoản điều chỉnh được giữ (BR-116, BR-119).
- **Exceptions:**
  - `1a`. Bảng công của tháng chưa chốt: không tính được (BR-102).
  - `5a`. Còn lỗi, phiếu có thực lĩnh âm, hoặc bảng lương Cần tính lại: không chốt được (BR-117).
  - `5b`. Hai HR cùng chốt: chỉ một thao tác thành công (EC-072).
- **Postconditions:** Bảng lương đã chốt không đổi và không mở lại được; sai sót được sửa bằng khoản điều chỉnh ở kỳ sau
  (BR-118). Bảng công của tháng không mở lại được nữa (BR-091). Mọi bước được ghi nhật ký (BR-124).

### UC-011: Thay đổi lương của nhân viên

- **Actor:** HR · **Stories:** US-051
- **Trigger:** Nhân viên được tăng lương, đổi phụ cấp, hoặc ký hợp đồng mới với mức lương khác.
- **Preconditions:** Nhân viên đang làm việc hoặc sắp vào làm.
- **Main flow:**
  1. HR mở tab Lương của nhân viên và chọn Thay đổi lương.
  2. HR nhập ngày hiệu lực, lương cơ bản, lương đóng bảo hiểm và các phụ cấp, kèm lý do.
  3. Hệ thống kiểm mức sàn (BR-094, BR-096) và hiện bản ghi lương trước và sau thay đổi.
  4. HR xác nhận. Hệ thống lưu; bản ghi trước kết thúc ở ngày trước ngày hiệu lực (BR-093).
- **Alternative flows:**
  - `3a`. Lương đóng bảo hiểm thấp hơn lương cơ bản: hệ thống cảnh báo; HR xác nhận thì vẫn lưu (BR-095).
  - `3b`. Ngày hiệu lực thuộc tháng có bảng lương nháp: bảng lương đó được đánh dấu Cần tính lại (BR-119).
  - `3c`. Ngày hiệu lực thuộc tháng có bảng lương đã chốt: hệ thống cảnh báo và hiện chênh lệch của từng tháng để HR thêm
    khoản truy lĩnh hoặc truy thu ở kỳ chưa chốt (BR-098, EC-063).
- **Exceptions:**
  - `3d`. Lương cơ bản hoặc lương đóng bảo hiểm dưới lương tối thiểu vùng: từ chối (BR-094, BR-096).
  - `2a`. Đã có bản ghi lương khác cùng ngày hiệu lực: từ chối; HR sửa bản ghi đó (EC-089).
- **Postconditions:** Các bản ghi lương của nhân viên không chồng, không hở (BR-093); nhật ký ghi giá trị trước và sau.

### UC-012: Xem báo cáo chi phí lương

- **Actor:** Quản lý, HR · **Stories:** US-069, US-070
- **Trigger:** Ban giám đốc hoặc trưởng phòng ban cần biết chi phí nhân sự của một hoặc nhiều tháng.
- **Preconditions:** Có ít nhất một bảng lương đã chốt; với HR, đã có bảng lương Nháp.
- **Main flow:**
  1. Người xem mở báo cáo chi phí lương và chọn khoảng tháng.
  2. Hệ thống lấy các phiếu lương của bảng lương đã chốt, xếp mỗi nhân viên vào phòng ban tại ngày cuối tháng mà người đó
     còn làm (BR-127, BR-131).
  3. Hệ thống tổng hợp theo phòng ban trong phạm vi: số người, tổng thu nhập, phần công ty đóng, tổng chi phí, kèm so
     sánh với tháng trước.
  4. Người xem chọn một phòng ban để xem theo phòng ban con, hoặc xuất ra bảng tính (BR-136).
- **Alternative flows:**
  - `2a`. Người xem là HR: thêm tháng có bảng lương Nháp, đánh dấu tạm tính (BR-130), và xem được tới từng nhân viên.
  - `3a`. Người xem là Quản lý và một phòng ban có dưới `report_min_group_size` người: số liệu được gộp vào phòng ban cha
    (BR-129, EC-078).
- **Exceptions:**
  - `3b`. Cả phạm vi của Quản lý có dưới `report_min_group_size` người: không hiện số liệu và ghi lý do (BR-129, EC-079).
  - `4a`. Mở báo cáo của phòng ban ngoài phạm vi bằng đường dẫn trực tiếp: từ chối (BR-127, EC-086).
- **Postconditions:** Quản lý không suy ra được lương của từng người. Mỗi lần xuất được ghi nhật ký (BR-136).

### UC-013: Tạo đơn nghỉ với AI Leave Coordinator

Giai đoạn 1 và 2 của AI Leave Coordinator: tiếp nhận, hiểu yêu cầu và đề xuất phương án. Chạy cả khi nhân viên dùng
form lẫn khi dùng chat.

- **Actor:** Nhân viên · **Stories:** US-082, US-083, US-084
- **Trigger:** Nhân viên mô tả nhu cầu nghỉ bằng một câu, trong chat hoặc ở form, hoặc điền form.
- **Preconditions:** Như UC-005.
- **Main flow:**
  1. Nhân viên nhập câu mô tả, hoặc điền lý do, loại nghỉ, ngày, buổi và mô tả thêm.
  2. AI diễn giải thành bản nháp: ngày, buổi, lý do trong danh mục (BR-166). Với form, AI kiểm mô tả thêm có khớp lý do
     đã chọn (BR-167).
  3. Core tính dữ kiện của bản nháp: loại nghỉ hợp lệ, số ngày, số phép tại từng ngày, mức phủ, giai đoạn hạn chế
     (BR-142, BR-044, BR-053, BR-146, BR-147).
  4. Core sinh các phương án hợp lệ; AI chọn tối đa `leave_option_count` phương án và ghi hệ quả của từng phương án
     (BR-168).
  5. Nhân viên chọn một phương án hoặc tự sửa, rồi bấm Gửi. Đây là điểm người xác nhận; AI không gửi thay (BR-155).
  6. Tiếp tục như UC-005 từ bước 4.
- **Alternative flows:**
  - `2a`. Câu thiếu thông tin hoặc AI không chắc: AI hỏi lại; nhân viên trả lời rồi quay lại bước 2 (BR-166).
  - `2b`. Câu gồm hai đợt nghỉ: AI tạo hai bản nháp (EC-093).
  - `5a`. Phương án gồm nhiều đơn: các đơn được gửi trong một lần xác nhận (BR-153).
- **Exceptions:**
  - `2c`. AI lỗi, chậm hoặc đầu ra không đạt kiểm tra: form giữ chữ đã gõ, nhân viên điền tay như UC-005 (BR-162,
    BR-163, EC-096).
  - `5b`. Dữ kiện đổi trước lúc gửi, như số dư: core từ chối như UC-005; AI đề xuất lại (EC-097).
- **Postconditions:** Đơn chỉ được tạo khi nhân viên bấm Gửi. Đơn có cờ có hỗ trợ AI; đầu ra của AI và lựa chọn cuối
  được lưu (BR-165).

### UC-014: Điều phối tình huống của đơn nghỉ

Giai đoạn 3 của AI Leave Coordinator: điều phối và thực thi. Rule làm phần cố định; AI giải thích và đề xuất cách xử
lý.

- **Actor:** Thời gian; Nhân viên, Quản lý, HR · **Stories:** US-077, US-078, US-085, US-086, US-087
- **Trigger:** Một tình huống ở BR-169, hoặc tới lịch ở BR-170, BR-171.
- **Preconditions:** Đơn hoặc phép tồn liên quan đang tồn tại.
- **Main flow:**
  1. Core phát sinh tình huống, hoặc tới lịch.
  2. Rule xử lý phần cố định: nhắc, báo HR, giao người duyệt thay, tính lại, hủy đơn (BR-148, BR-149, BR-064, BR-065).
  3. AI đọc dữ liệu của tình huống trong giới hạn BR-159, soạn giải thích, và soạn thẻ đề xuất khi có cách xử lý.
  4. Core kiểm đầu ra: đúng định dạng, con số khớp, người nhận chỉ thấy dữ liệu trong quyền của mình (BR-160, BR-163).
  5. Giải thích được gửi ngay, có nhãn AI (BR-156). Thẻ đề xuất chờ người có quyền bấm xác nhận (BR-157).
  6. Người nhận xác nhận hoặc bỏ qua thẻ. Đây là điểm người xác nhận; core thực hiện thao tác bằng phiên của người đó.
- **Alternative flows:**
  - `3a`. Cách xử lý cần thao tác tầng 3, như điều chỉnh số dư khi phép âm (EC-032): AI chỉ giải thích và liệt kê đơn
    cần xử lý cho HR (BR-158).
- **Exceptions:**
  - `3b`. AI lỗi hoặc đầu ra không đạt kiểm tra: người nhận thấy nội dung mẫu của rule (BR-162).
  - `6a`. Tình huống đã đổi trước khi người nhận xác nhận: core từ chối, thẻ hết hiệu lực (EC-104).
- **Postconditions:** Trạng thái đơn và số dư chỉ đổi qua core, do rule hoặc do người bấm. Mọi đầu ra của AI được lưu
  (BR-165).

### UC-015: Hỗ trợ người duyệt đơn nghỉ

Giai đoạn 4 của AI Leave Coordinator. AI giúp người duyệt hiểu tác động của đơn; quyết định luôn thuộc về người.

- **Actor:** Quản lý, HR · **Stories:** US-075, US-079, US-088, US-089
- **Trigger:** Người duyệt mở một đơn ở SCR-021.
- **Preconditions:** Đơn ở trạng thái Chờ duyệt; người xem là người duyệt, người duyệt thay hoặc HR.
- **Main flow:**
  1. Core hiện dữ kiện của đơn: lý do, phép trước và sau, đơn trùng ngày, mức phủ từng buổi, giai đoạn hạn chế
     (BR-146, BR-147).
  2. AI tóm tắt tác động của đơn và gợi ý khoảng ngày thay thế giữ phòng ban trên ngưỡng. AI không gợi ý duyệt hay từ
     chối (BR-164).
  3. Người duyệt chọn Duyệt, Từ chối hoặc Đề nghị đổi ngày. Đây là điểm người quyết định.
  4. Với Từ chối hoặc Đề nghị đổi ngày, người duyệt có thể nhờ AI soạn lý do hoặc lời nhắn, sửa rồi gửi (BR-059,
     BR-150).
  5. Core thực hiện như UC-005 hoặc BR-150.
- **Alternative flows:**
  - `2a`. AI lỗi: SCR-021 chỉ hiện dữ kiện của rule (BR-162).
- **Exceptions:**
  - `5a`. Người duyệt gốc và người duyệt thay cùng thao tác: thao tác đến trước có hiệu lực (EC-099).
- **Postconditions:** Mọi quyết định do người duyệt hoặc HR. Tóm tắt và bản nháp AI đã hiện được lưu (BR-165).

### UC-016: Phát hiện tín hiệu và tạo insight

Giai đoạn 1 và 2 của AI Report Analyst, chạy nền. Bước 1 tới 3 là lớp rule của M5; bước 4 tới 6 có từ M6.

- **Actor:** Thời gian · **Stories:** US-090, US-091, US-092, US-096, US-097
- **Trigger:** Lịch hằng đêm; HR chốt bảng công, chốt lại bảng công hoặc chốt bảng lương (BR-172).
- **Preconditions:** Có dữ liệu của M1 tới M4 cho kỳ cần tính.
- **Main flow:**
  1. Core tính các loại tín hiệu ở mục Default signal types của [domain](domain.md#default-signal-types) cho từng phòng
     ban và cả công ty, áp ngưỡng và mức tối thiểu (BR-172, BR-173).
  2. Core lưu tín hiệu mới, cập nhật tín hiệu đang có, và chuyển tín hiệu không còn đạt điều kiện sang Đã hết (BR-179).
     Mỗi tín hiệu có phân rã do core tính (BR-176).
  3. Tín hiệu mới mức Cao được thông báo tới những người xem được nó, trừ tình huống đã có thông báo (BR-177).
  4. Với mỗi phạm vi và vai trò có tín hiệu thay đổi, core gửi cho AI số liệu mức nhóm của tín hiệu và phân rã, đã gộp
     nhóm nhỏ (BR-182, BR-183).
  5. AI gom tín hiệu thành insight, viết tiêu đề và giải thích, chọn việc tiếp theo (BR-184, BR-186, BR-187, BR-190).
  6. Code kiểm đầu ra (BR-163, BR-188), rồi lưu insight kèm thời điểm tính (BR-189).
- **Alternative flows:**
  - `1a`. Phòng ban dưới `report_min_group_size` người, hoặc chưa đạt mức tối thiểu: không có tín hiệu (EC-106,
    EC-107).
  - `2a`. Bảng công của tháng tín hiệu dùng đang được mở lại: tín hiệu có cờ số liệu đang sửa (BR-179, EC-109).
- **Exceptions:**
  - `5a`. AI lỗi, chậm hoặc đầu ra không đạt kiểm tra: không có insight mới; trang tổng quan hiện thẻ cảnh báo của rule
    (BR-162, EC-113).
- **Postconditions:** Mọi con số trên thẻ và insight do core tính. AI không nhận dữ liệu của từng người. Đầu ra của AI
  được lưu (BR-165).

### UC-017: Xử lý điều đáng chú ý trên trang tổng quan

Giai đoạn 2 tới 4 của AI Report Analyst, phía người xem. Khi không có AI, người xem làm các bước này với thẻ cảnh báo
của rule.

- **Actor:** Quản lý, HR · **Stories:** US-091, US-093, US-094, US-095, US-097, US-098, US-099, US-100
- **Trigger:** Người xem mở SCR-040, hoặc bấm vào thông báo tín hiệu hay tóm tắt tuần.
- **Preconditions:** Người xem là Quản lý hoặc HR.
- **Main flow:**
  1. SCR-040 hiện tối đa `insight_max_count` insight theo phạm vi và vai trò; khi không có insight thì hiện thẻ cảnh báo
     (BR-175, BR-186).
  2. Người xem mở một thẻ ở SCR-048: số liệu, phân rã, so với kỳ trước và cùng kỳ năm trước, giải thích của AI (BR-176,
     BR-187).
  3. Người xem mở báo cáo đã lọc sẵn. Danh sách từng người chỉ hiện trong báo cáo, theo quyền của người xem (BR-137).
  4. Với loại tín hiệu có việc nhắc, AI soạn sẵn thẻ nhắc nhóm. Người xem sửa nội dung rồi bấm Gửi. Đây là điểm người
     xác nhận; core chọn người nhận tại lúc gửi (BR-185, BR-190).
  5. Người xem đánh giá thẻ, bấm Theo dõi hoặc Đóng (BR-178, BR-180).
  6. Khi tín hiệu đang theo dõi hết, hoặc tới hạn nhắc, người xem nhận cập nhật do AI viết (BR-180, BR-191).
- **Alternative flows:**
  - `1a`. Không có tín hiệu nào: SCR-040 ghi không có điều cần chú ý.
  - `4a`. Người xem không bấm Gửi: không ai nhận tin (BR-157).
  - `5a`. Người xem tắt một loại tín hiệu: thẻ và thông báo của loại đó dừng với người đó (BR-178).
- **Exceptions:**
  - `4b`. Người nhận đổi trước lúc gửi: core chọn lại người nhận (EC-115).
  - `6a`. AI lỗi: cập nhật và tóm tắt tuần dùng nội dung mẫu của rule (BR-191).
- **Postconditions:** Tin chỉ tới người khác khi người xem bấm Gửi. Đánh giá được lưu để đo tỷ lệ hữu ích; không ai xem
  được đánh giá của từng người (BR-178).

## Quality attributes

Mỗi dòng là một scenario có số đo. Importance và Difficulty xếp theo `H`, `M`, `L`; các dòng `H/H` và `H/M` là
architecture driver trong [ARCHITECTURE.md](../../ARCHITECTURE.md). Số đo phỏng đoán thì ghi `(assumption)`. Quy mô thiết kế
là công ty tới 300 nhân viên (A-011).

Cột Verify by ghi cách đo dự kiến. Test hay lần đo cụ thể ghi ở Traceability trong [SPEC](../build/SPEC.md).

| ID | Attribute | Scenario | Measure | Verify by | Importance / Difficulty |
|---|---|---|---|---|---|
| QA-001 | Data integrity | Hai người duyệt hai đơn phép năm của cùng một nhân viên trong cùng một giây, tổng số ngày vượt số dư (EC-024); tương tự với giới hạn giờ làm thêm (BR-084) và với hai thao tác chốt bảng lương (EC-072) | Đúng một thao tác thành công; số dư phép không âm; không vượt giới hạn | Integration test gửi hai request song song, lặp 100 lần | H / H |
| QA-002 | Correctness | Tính bảng lương trên bộ phiếu mẫu phủ EC-059 tới EC-077 và các ví dụ số trong US-055 tới US-062 | 100% phiếu khớp kết quả tính tay tới từng đồng | Test với bộ dữ liệu mẫu từ 30 phiếu trở lên, chạy ở mọi PR | H / M |
| QA-003 | Security | Người dùng gọi trực tiếp một thao tác ngoài quyền, kể cả xem dữ liệu ngoài phạm vi hay lương của người khác | 100% bị từ chối ở backend và ghi log; thông báo lỗi không lộ dữ liệu | Test tự động cho mọi dòng của ma trận phân quyền với cả ba vai trò | H / M |
| QA-004 | Performance | Công ty 300 nhân viên, dữ liệu 12 tháng, 30 người dùng cùng lúc | Mở danh sách, bảng công, báo cáo: p95 dưới 1 giây. Tính bảng lương 300 phiếu dưới 30 giây. Nhập file chấm công một tháng, khoảng 20.000 lượt chấm, dưới 60 giây (assumption) | Load test trên staging với dữ liệu giả | M / M |
| QA-005 | Recoverability | Cơ sở dữ liệu hỏng hoặc bị xóa nhầm | Mất tối đa 24 giờ dữ liệu; hệ thống chạy lại trong 4 giờ | Diễn tập khôi phục từ bản sao lưu mỗi quý, ghi thời gian vào runbook | H / L |
| QA-006 | Correctness (AI) | Diễn giải câu mô tả nghỉ tiếng Việt trên bộ ca có ngày tương đối, ngày lễ, lý do theo Điều 115 và câu thiếu thông tin | Ngày và buổi đúng ở ít nhất 95% số ca; lý do đúng mục ở ít nhất 90%; 100% ca thiếu thông tin được hỏi lại thay vì đoán (assumption) | Eval trên bộ ca tổng hợp, chạy khi đổi prompt, model hoặc pipeline | H / M |
| QA-007 | Security (AI) | Câu mô tả, dữ liệu do người khác nhập hoặc câu hỏi nhằm lấy dữ liệu ngoài quyền người nhận, hay nhằm khiến AI tự thao tác | 0 đầu ra chứa dữ liệu ngoài quyền người nhận; 0 thao tác ghi do AI tự thực hiện | Bộ ca tấn công trong eval; test tự động cho ba tầng hành động của AI (BR-155 tới BR-158) | H / H |
| QA-008 | Availability (AI) | Dịch vụ AI lỗi hoặc chậm | Mọi luồng nghỉ phép hoàn thành được bằng form và rule; gợi ý AI hiện trong 5 giây hoặc bị bỏ qua (assumption). Trang tổng quan hiện thẻ cảnh báo của rule; thông báo dùng nội dung mẫu | Test với AI bị tắt và bị làm chậm | H / L |
| QA-009 | Cost (AI) | Công ty 300 nhân viên dùng các tính năng AI bình thường trong một tháng | Chi phí dịch vụ AI không vượt ngân sách ở Q-031; vượt giới hạn thì AI tạm tắt và nghiệp vụ chạy theo BR-162 | Đo chi phí trên staging với dữ liệu giả; giới hạn chi tiêu đặt ở dịch vụ AI | M / L |
| QA-010 | Correctness (AI) | Tạo insight trên bộ ca tổng hợp gồm tín hiệu và phân rã của mọi loại tín hiệu, có ca gom nhiều tín hiệu và ca nhóm nhỏ | 0 insight được hiện có con số khác dữ kiện hoặc có tên người; ít nhất 90% giải thích nêu đúng thành phần đóng góp lớn nhất; ít nhất 95% không có khẳng định nguyên nhân ngoài phân rã (assumption) | Eval trên bộ ca tổng hợp: code chấm con số, tên và thành phần lớn nhất; LLM chấm theo rubric, kiểm lại một phần mẫu bằng tay. Chạy khi đổi prompt, model hoặc pipeline | H / M |

## Non-goals

Phạm vi ngoài baseline nằm ở mục Scope của [brief](../project/brief.md#scope). Riêng M1 không làm:

- Đăng nhập bằng tài khoản Google hoặc Microsoft: một công ty nhỏ chưa cần.
- Tự đặt lại mật khẩu qua email: HR đặt lại mật khẩu, vì chưa chắc mọi nhân viên có email công việc.
- Đính kèm file vào hồ sơ và hợp đồng, như bản scan CCCD hay hợp đồng: để sau baseline.

Riêng M2 không làm:

- Nghỉ theo giờ: đơn vị nhỏ nhất là nửa ngày.
- Duyệt nhiều cấp: chủ dự án chọn duyệt một cấp.
- Đính kèm giấy tờ vào đơn nghỉ, như giấy nghỉ ốm: nhân viên nộp bản giấy cho HR.
- Thông báo qua email hoặc ứng dụng chat: chỉ thông báo trong hệ thống.

Riêng M3 không làm:

- Kết nối trực tiếp với máy chấm công: HR nhập file, theo lựa chọn của chủ dự án.
- Chấm công trên web hoặc điện thoại: chủ dự án chọn nhập file từ máy.
- Xếp ca theo lịch và ca xoay: mỗi nhân viên một ca cố định.
- Quản lý giao làm thêm giờ cho nhân viên: nhân viên tự đăng ký, và việc tự đăng ký cũng là sự đồng ý mà luật yêu cầu.
- Tính tiền làm thêm giờ và phụ cấp ca đêm: làm ở M4.

Riêng M4 không làm:

- Chuyển tiền lương qua ngân hàng: hệ thống chỉ xuất file danh sách chuyển khoản để HR tải lên ngân hàng.
- Quyết toán thuế TNCN cuối năm: chủ dự án chọn chỉ tính khấu trừ hằng tháng.
- Tính và chi trả chế độ BHXH như ốm đau, thai sản: cơ quan BHXH chi trả; hệ thống chỉ ghi ngày nghỉ.
- Khai báo và nộp hồ sơ BHXH, tờ khai thuế điện tử.
- Quản lý chương trình phúc lợi riêng như bảo hiểm sức khỏe hay quà lễ: HR ghi bằng phụ cấp hoặc khoản điều chỉnh.
- Lương theo sản phẩm, doanh số, hoa hồng; nhiều kỳ trả lương trong tháng: tạm ứng giữa tháng ghi bằng khoản trừ.
- Nhân viên không cư trú về thuế và trả lương bằng ngoại tệ.

Riêng M5 không làm:

- Người dùng tự tạo báo cáo, tự chọn cột hay kéo thả biểu đồ: hệ thống có bộ báo cáo cố định.
- Gửi báo cáo định kỳ qua email.
- Phân tích và gợi ý bằng AI: làm ở M6, không thuộc bộ báo cáo cố định của M5.
- Báo cáo nộp cơ quan nhà nước như báo cáo tình hình sử dụng lao động: HR tự lập từ file xuất.

Riêng AI Leave Coordinator của M6 không làm:

- AI gợi ý duyệt hay từ chối, hoặc chấm điểm đơn: người duyệt quyết định (BR-164).
- AI dùng lịch sử nghỉ, số lần nghỉ ốm hay đánh giá của người gửi: theo phần Out của
  [brief](../project/brief.md#scope).
- Tự động duyệt đơn bằng AI hay theo chính sách: mọi đơn vẫn do người duyệt, trừ trường hợp tự duyệt ở EC-035.
- Thu thập nguyện vọng nghỉ trước khi có đơn: tổng hợp giai đoạn hạn chế chỉ dùng đơn đã gửi (BR-171).
- Gửi tin qua email hay ứng dụng chat ngoài hệ thống: như M2, chỉ thông báo trong hệ thống.

Riêng AI Report Analyst của M6 không làm:

- Nêu tên, đánh giá, xếp loại hay dự đoán về từng người: AI chỉ nhận số liệu mức nhóm (BR-182), theo phần Out của
  [brief](../project/brief.md#scope).
- Nêu nguyên nhân ngoài phân rã của core, như đổ cho lương hay cách quản lý (BR-184).
- Dự báo con số tương lai, như chi phí lương hay số người nghỉ việc tháng tới (BR-184).
- Tự tìm điều bất thường ngoài danh mục tín hiệu: rule phát hiện, AI chỉ gom và giải thích (BR-172, BR-186).
- Trả lời câu hỏi tự do về số liệu: để AI HR Assistant làm, dùng chung phân rã của core.
- Gửi insight hay tóm tắt tuần qua email hoặc ứng dụng chat ngoài hệ thống.
