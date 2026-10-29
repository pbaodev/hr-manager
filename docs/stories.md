# Stories: hr-manager

- **Status:** Draft
- **Updated:** 2026-10-30
- **Reviewed:** [YYYY-MM-DD: review nguội; AI review; người ngoài nếu có]
- **Related:** [requirements](requirements.md) · [domain](domain.md) · [ui-flow](ui-flow.md) · [SPEC](SPEC.md) ·
  [analysis guide](playbook/analysis.md)

## Summary

- **Priority:** `Must` khi thiếu story đó thì bản phát hành vô nghĩa; `Should`, `Could` cho phần còn lại.
- **Feature:** Issue Feature trên tracker chứa story; điền khi tạo Issue ở Phase 4.
- Bản hiện tại có story của M1. Story của M2–M5 được thêm ở lần phân tích của milestone đó.

| ID | Story | Priority | Milestone | Feature |
|---|---|---|---|---|
| US-001 | Đăng nhập và đổi mật khẩu | Must | M1 | |
| US-002 | HR quản lý tài khoản người dùng | Must | M1 | |
| US-003 | HR gán và thu hồi vai trò HR | Must | M1 | |
| US-004 | HR xem nhật ký thao tác | Should | M1 | |
| US-005 | HR quản lý danh mục chức danh | Must | M1 | |
| US-006 | HR tạo và sửa phòng ban | Must | M1 | |
| US-007 | HR giải thể phòng ban | Should | M1 | |
| US-008 | HR bổ nhiệm và thôi bổ nhiệm trưởng phòng ban | Must | M1 | |
| US-009 | Xem sơ đồ tổ chức hiện tại | Must | M1 | |
| US-010 | HR xem cơ cấu tổ chức tại một ngày trong quá khứ | Should | M1 | |
| US-011 | HR tiếp nhận nhân viên mới | Must | M1 | |
| US-012 | HR sửa hồ sơ nhân viên | Must | M1 | |
| US-013 | HR ghi nhận thay đổi công tác | Must | M1 | |
| US-014 | HR ghi nhận nghỉ việc | Must | M1 | |
| US-015 | HR quản lý hợp đồng lao động | Must | M1 | |
| US-016 | HR xem hợp đồng sắp hết hạn | Should | M1 | |
| US-017 | Nhân viên xem và cập nhật hồ sơ của mình | Must | M1 | |
| US-018 | Quản lý xem hồ sơ nhân viên trong phạm vi | Must | M1 | |
| US-019 | Tra cứu danh bạ nhân viên | Should | M1 | |
| US-020 | HR tìm và lọc danh sách nhân viên | Must | M1 | |
| US-021 | HR nhập danh sách nhân viên từ bảng tính | Could | M1 | |

## Details

### US-001: Đăng nhập và đổi mật khẩu

**Story:** Là nhân viên, tôi muốn đăng nhập bằng mã nhân viên và mật khẩu, và tự đổi mật khẩu, để dùng hệ thống an
toàn.

**Links:** BR-001, BR-002, BR-003, BR-005, BR-036 · EC-015 · SCR-001, SCR-002

**Acceptance criteria**

- AC1: Given tài khoản đang hoạt động, when đăng nhập đúng mã nhân viên và mật khẩu, then vào trang chủ.
- AC2: Given tài khoản mới tạo hoặc vừa được HR đặt lại mật khẩu, when đăng nhập, then phải đặt mật khẩu mới trước khi
  dùng chức năng khác (BR-002).
- AC3: Given đã nhập sai mật khẩu `max_failed_logins` lần liên tiếp, when đăng nhập tiếp, kể cả với mật khẩu đúng, then
  bị từ chối với thông báo tài khoản tạm khóa (BR-003).
- AC4: Given tài khoản bị HR khóa hoặc nhân viên đã nghỉ việc, when đăng nhập, then bị từ chối (BR-005).
- AC5: Given sai mã nhân viên hoặc sai mật khẩu, when đăng nhập, then thông báo chung "Mã nhân viên hoặc mật khẩu không
  đúng", không cho biết phần nào sai.
- AC6: Given mật khẩu mới ngắn hơn `min_password_length` hoặc trùng mật khẩu hiện tại, when đổi mật khẩu, then bị từ
  chối (BR-036).

### US-002: HR quản lý tài khoản người dùng

**Story:** Là HR, tôi muốn tạo, khóa, mở khóa tài khoản và đặt lại mật khẩu cho nhân viên, để chỉ người đang làm việc
mới vào được hệ thống.

**Links:** UC-001 · BR-001, BR-002, BR-004, BR-005 · SCR-016

**Acceptance criteria**

- AC1: Given nhân viên chưa có tài khoản, when HR tạo tài khoản, then tên đăng nhập là mã nhân viên và mật khẩu tạm hiện
  cho HR đúng một lần (BR-001, BR-002).
- AC2: Given nhân viên đã có tài khoản, when HR tạo thêm một tài khoản, then bị từ chối (BR-001).
- AC3: Given tài khoản đang hoạt động, when HR khóa, then người đó không đăng nhập được và các phiên đang mở của người đó
  kết thúc.
- AC4: Given nhân viên đã nghỉ việc, when HR mở khóa tài khoản của người đó, then bị từ chối (BR-005).
- AC5: Given HR đặt lại mật khẩu, then mật khẩu cũ hết tác dụng và người dùng phải đổi mật khẩu ở lần đăng nhập sau
  (BR-002).

### US-003: HR gán và thu hồi vai trò HR

**Story:** Là HR, tôi muốn gán hoặc thu hồi vai trò HR cho một tài khoản, để chỉ người làm nhân sự mới có quyền HR.

**Links:** BR-004, BR-006 · EC-010 · SCR-016

**Acceptance criteria**

- AC1: Given tài khoản chưa có vai trò HR, when HR gán vai trò HR, then người đó có quyền HR từ thao tác kế tiếp và nhật
  ký ghi người gán.
- AC2: Given chỉ còn một tài khoản HR đang hoạt động, when thu hồi vai trò HR của tài khoản đó, then bị từ chối (BR-004).
- AC3: Given HR muốn cho một người quyền Quản lý, then không có thao tác gán; người đó có vai trò Quản lý khi được bổ
  nhiệm làm trưởng phòng ban (BR-006).

### US-004: HR xem nhật ký thao tác

**Story:** Là HR, tôi muốn xem ai đã thay đổi gì và lúc nào, để truy lại khi dữ liệu bị sai.

**Links:** BR-030, BR-031 · SCR-017

**Acceptance criteria**

- AC1: Given HR đã đổi số điện thoại của một nhân viên, when xem nhật ký của hồ sơ đó, then thấy người sửa, thời điểm,
  giá trị trước và sau.
- AC2: Given một dòng nhật ký, then không có thao tác nào sửa hoặc xóa được dòng đó (BR-031).
- AC3: Given người không có vai trò HR, when mở nhật ký, then bị từ chối.

### US-005: HR quản lý danh mục chức danh

**Story:** Là HR, tôi muốn quản lý danh sách chức danh, để xếp chức danh cho nhân viên thống nhất.

**Links:** BR-034, BR-035 · SCR-015

**Acceptance criteria**

- AC1: Given tên chức danh chưa có, when HR thêm, then chức danh xuất hiện trong lựa chọn khi xếp công tác.
- AC2: Given tên trùng với một chức danh đã có, không phân biệt hoa thường, when thêm, then bị từ chối (BR-034).
- AC3: Given chức danh đã được dùng trong một quá trình công tác, when HR xóa, then bị từ chối; HR chỉ ngừng dùng được.
  Chức danh ngừng dùng không còn trong lựa chọn mới, còn quá trình công tác cũ vẫn giữ chức danh đó (BR-035).

### US-006: HR tạo và sửa phòng ban

**Story:** Là HR, tôi muốn tạo phòng ban, đổi tên và đổi phòng ban cha với ngày hiệu lực, để cơ cấu trên hệ thống khớp
với thực tế.

**Links:** UC-004 · BR-007, BR-008, BR-009, BR-012 · EC-006 · SCR-014

**Acceptance criteria**

- AC1: Given phòng ban cha đang hoạt động, when HR tạo một phòng ban con với ngày thành lập D, then từ ngày D phòng ban
  con xuất hiện trong sơ đồ tổ chức.
- AC2: Given phòng ban A là cha của B, when HR đặt B làm cha của A, then bị từ chối vì tạo thành vòng (BR-008).
- AC3: Given HR đổi tên phòng ban với ngày hiệu lực D, when xem cơ cấu tại một ngày trước D, then thấy tên cũ (BR-009).
- AC4: Given HR chuyển phòng ban sang nhánh khác từ ngày D, then từ D quản lý trực tiếp của nhân viên trong phòng ban
  đó được tính theo nhánh mới (BR-012, EC-006).

### US-007: HR giải thể phòng ban

**Story:** Là HR, tôi muốn giải thể một phòng ban không còn hoạt động, để sơ đồ tổ chức chỉ còn phòng ban có thật.

**Links:** UC-004 · BR-007, BR-010 · EC-007, EC-022 · SCR-014

**Acceptance criteria**

- AC1: Given từ ngày D phòng ban không còn nhân viên và không còn phòng ban con đang hoạt động, when HR giải thể từ D,
  then từ D phòng ban không còn trong sơ đồ và không xếp được nhân viên vào.
- AC2: Given từ ngày D vẫn còn nhân viên thuộc phòng ban, kể cả nhân viên được chuyển tới trong tương lai, when giải thể,
  then bị từ chối và hiện danh sách nhân viên cần chuyển đi (BR-010, EC-022).
- AC3: Given phòng ban gốc, when giải thể, then bị từ chối (BR-007).

### US-008: HR bổ nhiệm và thôi bổ nhiệm trưởng phòng ban

**Story:** Là HR, tôi muốn bổ nhiệm trưởng cho phòng ban từ một ngày, để hệ thống biết ai quản lý ai.

**Links:** BR-006, BR-011, BR-012, BR-013 · EC-004, EC-005, EC-011, EC-021 · SCR-014

**Acceptance criteria**

- AC1: Given phòng ban chưa có trưởng, when HR bổ nhiệm nhân viên X từ ngày D, then từ D X có vai trò Quản lý với phạm vi
  gồm phòng ban đó và mọi phòng ban con (BR-006, BR-013).
- AC2: Given phòng ban đã có trưởng tại ngày D, when HR chọn thay trưởng từ D, then bổ nhiệm cũ kết thúc ngày D−1 và bổ
  nhiệm mới bắt đầu từ D (BR-011).
- AC3: Given X thôi làm trưởng và không còn là trưởng phòng ban nào khác, then X mất vai trò Quản lý từ ngày thôi bổ
  nhiệm.
- AC4: Given X chưa vào làm hoặc đã nghỉ việc tại một ngày trong khoảng bổ nhiệm, when bổ nhiệm, then bị từ chối
  (BR-011).

### US-009: Xem sơ đồ tổ chức hiện tại

**Story:** Là nhân viên, tôi muốn xem sơ đồ tổ chức, để biết công ty có những phòng ban nào và ai phụ trách.

**Links:** BR-007, BR-009 · SCR-006

**Acceptance criteria**

- AC1: Given cơ cấu hôm nay, when mở sơ đồ, then thấy cây phòng ban, tên trưởng và số nhân viên đang làm của mỗi phòng
  ban.
- AC2: Given phòng ban đã giải thể, then phòng ban đó không hiện trong sơ đồ hiện tại.
- AC3: Given phòng ban có ngày thành lập ở tương lai, then phòng ban đó chưa hiện trong sơ đồ hiện tại.

### US-010: HR xem cơ cấu tổ chức tại một ngày trong quá khứ

**Story:** Là HR, tôi muốn xem cơ cấu tổ chức và nhân sự tại một ngày bất kỳ, để đối chiếu khi có tranh chấp hoặc khi
làm báo cáo.

**Links:** BR-009, BR-016 · EC-013 · SCR-006

**Acceptance criteria**

- AC1: Given X chuyển từ phòng A sang phòng B ngày 01/03, when HR xem cơ cấu ngày 28/02, then X nằm ở phòng A.
- AC2: Given một ngày trước ngày thành lập phòng ban gốc, when xem, then hiện cơ cấu trống kèm thông báo (EC-013).
- AC3: Given người không có vai trò HR, when chọn một ngày khác hôm nay, then bị từ chối.

### US-011: HR tiếp nhận nhân viên mới

**Story:** Là HR, tôi muốn tạo hồ sơ cho người mới cùng phòng ban, chức danh và hợp đồng đầu tiên trong một lần, để
người đó có đủ dữ liệu từ ngày vào làm.

**Links:** UC-001 · BR-014, BR-015, BR-016, BR-022, BR-024, BR-028 · EC-001, EC-008, EC-017, EC-018 · SCR-009

**Acceptance criteria**

- AC1: Given đủ thông tin bắt buộc, when HR xác nhận, then có hồ sơ với mã nhân viên mới, một quá trình công tác bắt đầu
  từ ngày vào làm và hợp đồng nếu đã nhập.
- AC2: Given ngày vào làm ở tương lai, then hồ sơ ở trạng thái Sắp vào làm và không hiện trong danh bạ cho tới ngày đó
  (EC-001).
- AC3: Given số CCCD trùng với một hồ sơ đã có, when lưu, then bị từ chối và dẫn tới hồ sơ đó (BR-022, EC-018).
- AC4: Given một bước bị lỗi, when xác nhận thất bại, then không có hồ sơ, quá trình công tác hay hợp đồng nào được lưu.

### US-012: HR sửa hồ sơ nhân viên

**Story:** Là HR, tôi muốn sửa thông tin cá nhân và liên hệ của nhân viên, để hồ sơ luôn đúng.

**Links:** BR-015, BR-030 · EC-016 · SCR-008

**Acceptance criteria**

- AC1: Given HR sửa số điện thoại của nhân viên, when lưu, then giá trị mới hiện ngay và nhật ký ghi giá trị cũ (BR-030).
- AC2: Given hai HR mở cùng một hồ sơ, when người thứ hai lưu sau khi người thứ nhất đã lưu, then người thứ hai được báo
  hồ sơ đã thay đổi và dữ liệu không bị ghi đè (EC-016).
- AC3: Given HR muốn đổi phòng ban hoặc chức danh, then không sửa trực tiếp được trên hồ sơ; HR phải ghi nhận thay đổi
  công tác (US-013).
- AC4: Given mã nhân viên, then không có thao tác sửa (BR-015).

### US-013: HR ghi nhận thay đổi công tác

**Story:** Là HR, tôi muốn ghi nhận việc chuyển phòng ban hoặc đổi chức danh với ngày hiệu lực, để giữ đúng lịch sử công
tác.

**Links:** UC-002 · BR-014, BR-016, BR-017, BR-018 · EC-002, EC-003, EC-004 · SCR-010

**Acceptance criteria**

- AC1: Given X ở phòng A từ 01/01, when HR ghi nhận chuyển sang phòng B từ 01/03, then quá trình ở phòng A kết thúc
  28/02 và quá trình ở phòng B bắt đầu 01/03 (BR-017).
- AC2: Given ngày hiệu lực ở tương lai, then hồ sơ hiện thay đổi sắp tới; khi tới ngày đó, X tự thuộc phòng mới.
- AC3: Given ngày hiệu lực ở quá khứ và lý do để trống, when lưu, then bị từ chối (BR-018).
- AC4: Given đã có một thay đổi khác cùng ngày hiệu lực, when lưu, then bị từ chối (EC-002).
- AC5: Given phòng ban đích không hoạt động tại ngày hiệu lực, when lưu, then bị từ chối (BR-014).

### US-014: HR ghi nhận nghỉ việc

**Story:** Là HR, tôi muốn ghi nhận ngày làm việc cuối cùng và lý do nghỉ của nhân viên, để hệ thống tự dừng quyền truy
cập và các phân công của người đó.

**Links:** UC-003 · BR-004, BR-005, BR-019, BR-020 · EC-005, EC-009 · SCR-011

**Acceptance criteria**

- AC1: Given ngày làm việc cuối cùng là L, when HR xác nhận, then từ ngày sau L nhân viên ở trạng thái Đã nghỉ việc, tài
  khoản bị khóa, còn bổ nhiệm trưởng và hợp đồng đang hiệu lực kết thúc ở L (BR-019).
- AC2: Given L chưa qua, when HR hủy ghi nhận, then không tác động nào ở AC1 xảy ra (BR-020).
- AC3: Given còn thay đổi công tác có hiệu lực sau L, when xác nhận, then bị từ chối và hiện danh sách thay đổi cần hủy
  (EC-009).
- AC4: Given nhân viên đã nghỉ việc, then hồ sơ vẫn xem được và tìm được bằng bộ lọc trạng thái Đã nghỉ việc.

### US-015: HR quản lý hợp đồng lao động

**Story:** Là HR, tôi muốn ghi lại các hợp đồng lao động của nhân viên, để biết mỗi người đang có hợp đồng loại nào và
hết hạn khi nào.

**Links:** UC-001 · BR-023 tới BR-028, BR-037 · EC-014 · SCR-012

**Acceptance criteria**

- AC1: Given hợp đồng xác định thời hạn, when ngày kết thúc để trống hoặc quá `fixed_term_max_months` tháng sau ngày bắt
  đầu, then bị từ chối (BR-024).
- AC2: Given hợp đồng mới chồng thời gian với một hợp đồng đã có, when lưu, then bị từ chối (BR-025, EC-014).
- AC3: Given hai hợp đồng liền trước đều là xác định thời hạn, when HR thêm hợp đồng xác định thời hạn thứ ba, then hệ
  thống cảnh báo và chỉ lưu sau khi HR xác nhận (BR-026).
- AC4: Given hợp đồng thử việc dài hơn mức tối đa của nhóm công việc đã chọn, when lưu, then bị từ chối (BR-028).

### US-016: HR xem hợp đồng sắp hết hạn

**Story:** Là HR, tôi muốn thấy danh sách hợp đồng sắp hết hạn và hợp đồng đã hết hạn mà chưa ký tiếp, để kịp ký hợp
đồng mới.

**Links:** BR-027, BR-029 · SCR-003, SCR-013

**Acceptance criteria**

- AC1: Given hợp đồng kết thúc trong `contract_expiry_warning_days` ngày tới, then hợp đồng nằm trong danh sách, xếp
  theo ngày kết thúc (BR-029).
- AC2: Given hợp đồng xác định thời hạn đã hết hạn, nhân viên vẫn làm việc và chưa có hợp đồng mới, then hợp đồng nằm
  trong danh sách kèm số ngày còn lại trước khi luật coi là hợp đồng không xác định thời hạn (BR-027).
- AC3: Given nhân viên đã có hợp đồng tiếp theo, then hợp đồng cũ không nằm trong danh sách.

### US-017: Nhân viên xem và cập nhật hồ sơ của mình

**Story:** Là nhân viên, tôi muốn xem hồ sơ, quá trình công tác, hợp đồng của mình và tự sửa thông tin liên hệ, để thông
tin của tôi luôn đúng mà không phải nhờ HR.

**Links:** BR-021 · EC-012 · SCR-004

**Acceptance criteria**

- AC1: Given nhân viên đã đăng nhập, when mở hồ sơ của mình, then thấy thông tin cá nhân, quá trình công tác và hợp đồng
  của mình.
- AC2: Given nhân viên sửa số điện thoại cá nhân, when lưu, then giá trị mới có hiệu lực ngay và nhật ký ghi lại
  (BR-021).
- AC3: Given nhân viên muốn sửa tài khoản ngân hàng, CCCD, phòng ban hoặc chức danh, then không có thao tác sửa; màn
  hình hướng dẫn liên hệ HR (BR-021, EC-012).

### US-018: Quản lý xem hồ sơ nhân viên trong phạm vi

**Story:** Là quản lý, tôi muốn xem thông tin công việc của nhân viên trong phạm vi mình phụ trách, để nắm được đội ngũ.

**Links:** BR-012, BR-013, BR-033 · SCR-007, SCR-008

**Acceptance criteria**

- AC1: Given X thuộc một phòng ban con của phòng ban mình làm trưởng, when quản lý mở danh sách nhân viên, then thấy X
  với thông tin công việc và quá trình công tác.
- AC2: Given Y thuộc phòng ban ngoài phạm vi, when quản lý mở hồ sơ của Y bằng đường dẫn trực tiếp, then bị từ chối.
- AC3: Given X trong phạm vi, then quản lý không thấy CCCD, ngày sinh, địa chỉ, tài khoản ngân hàng, liên hệ khẩn cấp và
  hợp đồng của X (BR-033).

### US-019: Tra cứu danh bạ nhân viên

**Story:** Là nhân viên, tôi muốn tìm đồng nghiệp theo tên hoặc phòng ban, để biết cách liên lạc.

**Links:** BR-032 · EC-019 · SCR-005

**Acceptance criteria**

- AC1: Given tìm theo một phần họ tên, then thấy các nhân viên đang làm có tên khớp, kể cả khi gõ không dấu (EC-019).
- AC2: Given một kết quả, then chỉ hiện họ tên, chức danh, phòng ban, email và số điện thoại công việc (BR-032).
- AC3: Given nhân viên đã nghỉ việc hoặc sắp vào làm, then người đó không hiện trong danh bạ.

### US-020: HR tìm và lọc danh sách nhân viên

**Story:** Là HR, tôi muốn tìm và lọc nhân viên theo phòng ban, chức danh, trạng thái và loại hợp đồng, để thao tác
nhanh trên đúng người.

**Links:** EC-019 · SCR-007

**Acceptance criteria**

- AC1: Given lọc theo phòng ban A và chọn gồm phòng ban con, then thấy nhân viên của A và của mọi phòng ban con.
- AC2: Given lọc trạng thái Đã nghỉ việc, then thấy nhân viên đã nghỉ việc.
- AC3: Given tìm "nguyen van a", then tìm được "Nguyễn Văn A" (EC-019).
- AC4: Given kết quả dài hơn một trang, then có phân trang và tổng số kết quả.

### US-021: HR nhập danh sách nhân viên từ bảng tính

**Story:** Là HR, tôi muốn nhập danh sách nhân viên hiện có từ một file bảng tính, để không phải gõ lại từng người khi
công ty bắt đầu dùng hệ thống.

**Links:** BR-015, BR-016, BR-022 · EC-020 · SCR-018

**Acceptance criteria**

- AC1: Given file theo mẫu tải từ hệ thống, when HR tải lên, then hệ thống kiểm từng dòng và hiện dòng hợp lệ, dòng lỗi
  kèm lý do trước khi lưu.
- AC2: Given còn dòng lỗi, when HR xác nhận, then không dòng nào được lưu (EC-020).
- AC3: Given mã nhân viên hoặc số CCCD trong file trùng với hồ sơ đã có hoặc trùng nhau trong file, then dòng đó bị đánh
  dấu lỗi (BR-015, BR-022).
- AC4: Given file hợp lệ, when HR xác nhận, then mỗi dòng thành một hồ sơ giữ nguyên mã nhân viên trong file, kèm một quá
  trình công tác bắt đầu từ ngày vào làm.
