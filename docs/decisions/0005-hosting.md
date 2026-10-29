# ADR-0005: Render cho production, gói miễn phí cho staging

- **Status:** Accepted
- **Date:** 2026-10-30
- **Reviewed:** 2026-10-30: chủ dự án chọn PaaS kèm PostgreSQL managed, ngân sách $10–25 mỗi tháng
- **Drivers:** QA-004, QA-005; ngân sách $10–25 mỗi tháng (Q-009); một người vận hành
- **Related:** ADR-0001, ADR-0003, ADR-0004, Q-009, [research](../research.md#legal-sources)

## Context

Cần môi trường production và staging; một web service chạy backend kèm SPA; PostgreSQL có backup để mất tối đa 24 giờ
dữ liệu và khôi phục trong 4 giờ (QA-005); job theo lịch cho actor Thời gian. Frontend và API phải cùng domain để cookie
`SameSite=Strict` của ADR-0004 hoạt động. `onrender.com` nằm trong public suffix list, nên hai subdomain khác nhau của nó
bị trình duyệt coi là hai site khác nhau.

Giá dưới đây tra ngày 2026-10-30 từ trang của nhà cung cấp và các bài so sánh; giá đổi thường xuyên nên phải kiểm lại khi
tạo tài khoản (assumption).

## Decision

- **Production trên Render:** một web service gói Starter chạy FastAPI, phục vụ cả SPA đã build; một Render Postgres gói
  trả phí nhỏ nhất; một cron job service chạy lệnh của actor Thời gian. Chọn vùng Singapore, vùng gần Việt Nam nhất. Dự
  kiến khoảng $15 mỗi tháng.
- **Backup:** point-in-time recovery của Render Postgres, giữ 3 ngày ở gói Hobby, cộng bản logical backup tải về hằng
  tuần. Diễn tập khôi phục mỗi quý theo QA-005.
- **Staging:** web service gói miễn phí của Render và PostgreSQL gói miễn phí của Neon, vì PostgreSQL miễn phí của Render
  hết hạn sau 30 ngày. Staging được phép ngủ và khởi động chậm.
- **Secret:** biến môi trường của từng service trên Render; `.env` chỉ ở local.

## Options considered

| Option | Pros | Cons | Fit with drivers |
|---|---|---|---|
| Render web service, Postgres và cron | Một nhà cung cấp; deploy từ GitHub; cron job có sẵn; PITR 3 ngày ở Hobby, 7 ngày ở Pro. Khoảng $7 web, $6–7 DB, cron từ $1 mỗi tháng | Bảng gói workspace đổi giữa năm 2026; băng thông của gói Hobby thấp | QA-005: đạt bằng PITR. Chi phí khoảng $15, trong ngân sách |
| Railway | Gói Hobby $5 có $5 usage; tính tiền theo giây; backup volume hằng ngày giữ 6 ngày | Chi phí theo usage khó đoán; tài liệu chưa nói rõ gói nào có backup; cron phải tự cấu hình | QA-005: đạt nếu gói có backup. Chi phí khoảng $10–15 |
| App trên Render, DB trên Neon | Neon Launch có PITR tới 7 ngày, scale-to-zero, tính theo usage | Hai nhà cung cấp cho production; DB ngủ sau 5 phút làm request đầu chậm, trừ khi tắt scale-to-zero và trả thêm | QA-004: request đầu chậm khi DB ngủ. QA-005: đạt |

## Consequences

- **Easier:** một nơi xem log, deploy và backup của production; frontend và API cùng domain nên không cần CORS.
- **Harder:** staging và production khác nhà cung cấp DB, nên phải giữ cùng phiên bản PostgreSQL chính; staging không
  đo được QA-004.
- **Follow-up:**
  - Kiểm lại giá và gói workspace trước khi tạo dịch vụ.
  - Dùng domain riêng khi có công ty dùng thật.
  - Máy chủ ở Singapore là chuyển dữ liệu cá nhân ra nước ngoài theo Luật Bảo vệ dữ liệu cá nhân 2025: trước khi nhập dữ
    liệu thật, lập hồ sơ đánh giá tác động chuyển dữ liệu, hoặc chuyển sang hosting tại Việt Nam.

## Revisit when

Có dữ liệu nhân viên thật mà chưa lập hồ sơ chuyển dữ liệu ra nước ngoài; chi phí vượt $25 mỗi tháng; Render đổi gói làm
mất PITR; hoặc QA-004 không đạt trên gói Starter.
