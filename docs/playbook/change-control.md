# Change control

Áp dụng sau Exit criteria của Phase 3, khi requirements, domain, tài liệu thiết kế và SPEC đã `Accepted`. Trước mốc đó,
mọi thay đổi đi qua PR bình thường. Làm một mình thì không có ai duyệt; change control ở đây để giữ lý do của thay đổi,
và để tài liệu, code và test đổi cùng nhau.

## Classify the change

| Type | Example | Process |
|---|---|---|
| Fix | Code làm khác tài liệu | Issue Bug, PR thường |
| Clarification | Tài liệu mơ hồ; bổ sung mà không đổi hành vi | PR sửa tài liệu; SPEC ghi Changelog |
| New feature | Thêm user story mới | Issue Feature, đi theo Feature loop ở [phases.md](phases.md) |
| Behavior | Đổi acceptance criteria hoặc business rule; đổi prompt hay model làm hành vi người dùng thấy thay đổi | CR |
| Interface or data | Đổi contract, schema hoặc migration theo cách không tương thích ngược | CR |
| Architecture | Đổi stack, architecture style, container, hoặc cách đáp ứng một driver | CR và ADR mới |
| Scope | Bỏ story đã cam kết; đổi hướng sản phẩm | CR; cập nhật brief, requirements và stories |

Mức ảnh hưởng không tính theo số dòng code: thêm một cột bắt buộc có thể ảnh hưởng nhiều hơn viết lại cả một module.
Không chắc thay đổi thuộc loại nào thì chọn loại nặng hơn.

## CR process

1. Mở Issue theo [mẫu Change Request](../../.github/ISSUE_TEMPLATE/change_request.md). Mã CR là `CR-` cộng số Issue,
   ví dụ `CR-42`.
2. Ghi hiện trạng, đề xuất, lý do và ảnh hưởng tới story, luật, contract, thiết kế và ADR.
3. CR loại Interface, Architecture hoặc Scope cần review nguội: ghi quyết định sau ít nhất một đêm.
4. Một PR cập nhật cùng lúc tài liệu nguồn, code và test. SPEC tăng version, và Changelog ghi mã CR.
5. CR đóng khi PR đã merge. Việc cần theo dõi sau thay đổi ghi vào Issue.

Không sửa một quyết định đã `Accepted` để trông như phương án mới được chọn từ đầu. ADR cũ chuyển sang
`Superseded by ADR-NNNN`.

## Emergencies

Khi có sự cố Severe (xem Incident ở Phase 5 trong [phases.md](phases.md)), rollback, tắt tính năng hoặc thu hồi key
trước mà không chờ CR. Trong 48 giờ, mở CR hoặc Bug ghi lại thay đổi đã làm và cập nhật tài liệu liên quan.
