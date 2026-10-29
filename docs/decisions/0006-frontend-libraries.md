# ADR-0006: Mantine, TanStack Query, openapi-fetch và React Router cho frontend

- **Status:** Accepted
- **Date:** 2026-10-30
- **Reviewed:** 2026-10-30: chủ dự án chọn thư viện UI và thư viện dữ liệu
- **Drivers:** QA-003; contract-first ở [api](../design/api.md); một người làm; giao diện có nhiều bảng, form và chọn
  ngày; mobile web cho màn hình của nhân viên
- **Related:** ADR-0002, [components](../design/components.md#frontend), [UI design](../design/ui.md)

## Context

Frontend là SPA React TypeScript (ADR-0002) do `api` phục vụ cùng domain. Màn hình gồm nhiều bảng có lọc và phân trang,
form nhiều bước, chọn ngày và buổi, thông báo. Giao diện chỉ có tiếng Việt. Type của API phải sinh từ
`contracts/openapi.yaml`, để contract đổi mà frontend chưa sửa thì build lỗi. Màn hình của nhân viên và duyệt đơn phải
dùng tốt trên trình duyệt điện thoại.

## Decision

- **Component:** Mantine, gồm `@mantine/core`, `@mantine/dates` với dayjs locale `vi`, `@mantine/form`,
  `@mantine/notifications`. Theme của Mantine là nơi giữ design token ở [UI design](../design/ui.md).
- **Dữ liệu từ server:** TanStack Query cho cache, tải lại và trạng thái; `openapi-fetch` gọi API với type sinh bằng
  `openapi-typescript` từ contract.
- **Routing:** React Router, mỗi màn hình `SCR-xxx` một route.
- Phiên bản cụ thể ghi trong lockfile khi dựng project (Issue #14), lấy bản ổn định mới nhất lúc đó.

## Options considered

| Option | Pros | Cons | Fit with drivers |
|---|---|---|---|
| Mantine | Đủ bảng, form, date picker, modal, notification; theme bằng token; accessibility tốt; nhẹ hơn Ant Design | Bảng dữ liệu nâng cao như cố định cột phải tự làm thêm | Một người làm nhanh; đáp ứng mobile web bằng breakpoint có sẵn |
| shadcn/ui + Tailwind | Accessibility tốt nhờ Radix; tùy biến thoải mái; code nằm trong repo | Bảng dữ liệu, chọn khoảng ngày phải tự ghép; nhiều code UI phải tự giữ | Tốn công hơn cho một người |
| Ant Design | Bảng và form rất đầy đủ; có locale `vi_VN` | Nặng; giao diện đặc trưng, khó đổi theme | Đạt chức năng; bundle lớn hơn cho mobile web |
| SWR thay TanStack Query | Nhẹ, API đơn giản | Mutation và tải lại theo nhóm key kém tiện | Đạt, nhưng nhiều code tay hơn khi có nhiều form |
| Orval sinh hook | Ít code tay nhất | Thêm bước sinh code phức tạp; code sinh ra khó đọc | Đạt contract-first, nhưng khó debug |
| TanStack Router thay React Router | Route có type chặt | Ít phổ biến hơn; thêm một khái niệm để học | Không có driver nào cần |

## Consequences

- **Easier:** gọi sai path hay field của API là lỗi lúc build; màn hình dùng chung một bộ component và token.
- **Harder:** giao diện mang dáng của Mantine; đổi thư viện UI về sau phải viết lại phần lớn màn hình.
- **Follow-up:** dựng project frontend với các thư viện này ở Issue #14; thêm bước sinh type từ contract vào
  `make check`.

## Revisit when

Cần app di động cài đặt; cần bảng dữ liệu nâng cao mà Mantine không đáp ứng; hoặc Mantine ngừng được duy trì.
