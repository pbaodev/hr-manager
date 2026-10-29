# Project: [tên dự án]

- **Status:** [Draft | Accepted]
- **Updated:** [YYYY-MM-DD]

> Điền ở Phase 0. Default nằm ở [working-agreement.md](playbook/working-agreement.md), [hats.md](playbook/hats.md) và
> [phases.md](playbook/phases.md); file này chỉ ghi mục tiêu, nhịp làm việc, công cụ và những chỗ làm khác default.
> Sửa qua PR, ghi lý do và ngày. Dòng in nghiêng là ví dụ, xóa khi điền.

## Goals

- **Product goal:** [sản phẩm giúp ai làm được gì, một câu]
- **Project type:** [Experiment | Personal tool | Product | Client delivery], theo bảng Project types trong
  [playbook](playbook/README.md)
- **Receiving party:** [chỉ cho Client delivery: bên nhận, người xác nhận phạm vi và nghiệm thu]
- **Learning goals:** [kỹ năng muốn luyện qua dự án này; xem lại ở mỗi retro]
  - *Thiết kế data model có luật nhất quán khi nhiều người cùng ghi*
  - *Viết ADR so sánh ít nhất hai phương án thật*

## Cadence

- **Time budget:** [số giờ mỗi tuần]
- **Weekly review:** [thứ, giờ]
- **Target release:** [YYYY-MM-DD, hoặc "không có hạn"]

| Milestone | Target date | Scope |
|---|---|---|
| *M1* | *[YYYY-MM-DD]* | *Walking skeleton: đặt một phòng, chạy trên staging* |

## Tools

| Purpose | Choice |
|---|---|
| Code and review | [GitHub] |
| Tracker and board | [GitHub Issues + GitHub Projects; link tới board]; label và Issue baseline tạo bằng `scripts/bootstrap-github.sh` |
| Agent access to tracker | [`gh` CLI / GitHub MCP] |
| AI agent | [Claude Code / Codex / Cursor / …] |
| Diagrams | Mermaid trong Markdown |
| Hosting | [chọn ở Phase 3, dẫn ADR] |
| Secrets | [password manager] |

## Deviations from default

| Topic | Default | My choice | Reason | Effective |
|---|---|---|---|---|
| *Review nguội* | *Ít nhất một đêm* | *Ít nhất 4 giờ* | *Chỉ làm vào cuối tuần, chờ qua đêm làm chậm cả tuần* | *[YYYY-MM-DD]* |

## Retro log

Ghi sau mỗi milestone. Cột cuối giúp nhìn lại những gì đã học được về phân tích và thiết kế.

| Milestone | Keep | Drop | Try | Learned about design | Date |
|---|---|---|---|---|---|
| *M1* | *Vẽ sequence diagram trước khi viết API* | *Vẽ component cho container mỏng* | *Đo QA-001 ngay từ M2* | *Exclusion constraint thay được việc khóa ở tầng app* | *[YYYY-MM-DD]* |
