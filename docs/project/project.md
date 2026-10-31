# Project: hr-manager

- **Status:** Accepted
- **Updated:** 2026-10-31

> Điền ở Phase 0. Default nằm ở [working-agreement.md](../playbook/working-agreement.md), [hats.md](../playbook/hats.md) và
> [phases.md](../playbook/phases.md); file này chỉ ghi mục tiêu, nhịp làm việc, công cụ và những chỗ làm khác default.
> Sửa qua PR, ghi lý do và ngày.

## Goals

- **Product goal:** Giúp HR và quản lý ở doanh nghiệp nhỏ và vừa tại Việt Nam quản lý nhân viên, cơ cấu tổ chức, chấm
  công, nghỉ phép và lương trên một hệ thống, để nhân viên tự xem thông tin và gửi yêu cầu thay vì hỏi HR qua tin nhắn
  hay bảng tính. AI trả lời câu hỏi lặp lại, giúp chọn đúng loại nghỉ và chỉ ra điều đáng chú ý trong báo cáo.
- **Project type:** Product, theo bảng Project types trong [playbook](../playbook/README.md)
- **Learning goals:**
  - Phân tích một domain có luật nghiệp vụ thật: phép năm, chấm công và lương, đối chiếu với Bộ luật Lao động; lập ma
    trận phân quyền cho nhiều vai trò.
  - Thiết kế data model giữ được luật nhất quán và dữ liệu theo thời gian: số dư phép không âm khi hai đơn được duyệt
    cùng lúc; chuyển phòng ban hay tăng lương có ngày hiệu lực, và xem lại được cơ cấu tổ chức tại một ngày bất kỳ.
  - Viết ADR so sánh ít nhất hai phương án thật cho mỗi quyết định khó đảo ngược.
  - Thiết kế tính năng AI như một component bình thường: bước nào dùng AI, quyền hành động của AI, điểm người xác nhận
    và eval.

## Cadence

- **Time budget:** khoảng 6 giờ mỗi ngày
- **Weekly review:** Chủ nhật hằng tuần
- **Target release:** chưa đặt; đặt sau khi prototype được duyệt và stack được chọn

| Milestone | Target date | Scope |
|---|---|---|
| Baseline | — | Phase 1–3: phân tích chi tiết M1–M6, prototype, rồi thiết kế kiến trúc, dữ liệu, API và giao diện |
| Prototype | — | UI prototype dùng dữ liệu giả, có design system, gồm màn hình của ba tính năng AI; nằm trong Baseline, trước Phase 3 |
| v1.0 | — | Bản phát hành đầu tiên cho công ty: mọi story của M1–M6 |
| M1 | — | Walking skeleton: đăng nhập, vai trò, hồ sơ nhân viên, cơ cấu tổ chức; chạy trên staging. Gồm thư viện quy chế và hộp câu hỏi gửi HR mà AI HR Assistant dựa vào (US-101 tới US-105) |
| M2 | — | Nghỉ phép, gồm phần rule mà AI Leave Coordinator dựa vào (US-073 tới US-081) |
| M3 | — | Chấm công |
| M4 | — | Lương và phúc lợi, gồm so sánh phiếu lương với tháng trước (US-106) |
| M5 | — | Báo cáo và phân tích, gồm phần rule mà AI Report Analyst dựa vào (US-090 tới US-095) |
| M6 | — | Ba tính năng AI theo thứ tự: AI Leave Coordinator, AI Report Analyst, AI HR Assistant |

## Tools

| Purpose | Choice |
|---|---|
| Code and review | GitHub |
| Tracker and board | GitHub Issues + GitHub Projects ([board](https://github.com/users/pbaodev/projects/6)); label và Issue baseline tạo bằng `scripts/bootstrap-github.sh` |
| Agent access to tracker | `gh` CLI |
| AI agent | Claude Code, Codex |
| Diagrams | Mermaid trong Markdown |
| Hosting | Chưa chọn; chọn ở Phase 3, sau prototype |
| Secrets | `.env` ở local; nơi lưu ở môi trường deploy chọn cùng hosting |

## Deviations from default

| Topic | Default | My choice | Reason | Effective |
|---|---|---|---|---|
| Phạm vi baseline | Baseline chỉ phân tích đủ cho các milestone đầu; module sau phân tích ở Feature loop ([phases.md](../playbook/phases.md)) | Baseline phân tích chi tiết M1–M6 và thiết kế cho toàn hệ thống | Muốn luyện phân tích và thiết kế toàn hệ thống trước khi code; AI ở M6 cần dữ liệu của cả năm module | 2026-10-29; đổi 2026-10-31 |
| Prototype trước Design | Sau Analysis là Design: chọn stack, thiết kế, rồi code ([phases.md](../playbook/phases.md)) | Giữa Analysis và Design có bước Prototype: dựng design system và UI prototype dùng dữ liệu giả, chưa viết code. Stack được chọn ở Phase 3, sau khi prototype được duyệt | Thử luồng nghiệp vụ và điểm người xác nhận của AI trên giao diện trước khi chọn công nghệ | 2026-10-31 |
| Phát hành | Mỗi milestone kết thúc bằng một bản phát hành ([phases.md](../playbook/phases.md)) | M1–M5 qua release gate trên staging nhưng không phát hành cho công ty; bản phát hành đầu tiên là v1.0 gồm M1–M6 | v1.0 phải có đủ nghiệp vụ và AI; release gate vẫn giữ để nghiệp vụ được kiểm đúng trước khi làm AI | 2026-10-31 |
| Agent đọc secret | Agent không đọc, không sửa secret ([hats.md](../playbook/hats.md)) | Agent được đọc `.env` ở local; vẫn không sửa secret và không chép giá trị secret vào code, test, log, prompt hay PR | Secret hiện chỉ là giá trị dev ở local; xem lại khi có production | 2026-10-29 |

## Retro log

Ghi sau mỗi milestone. Cột cuối giúp nhìn lại những gì đã học được về phân tích và thiết kế.

| Milestone | Keep | Drop | Try | Learned about design | Date |
|---|---|---|---|---|---|
