# Project: hr-manager

- **Status:** Accepted
- **Updated:** 2026-10-29

> Điền ở Phase 0. Default nằm ở [working-agreement.md](playbook/working-agreement.md), [hats.md](playbook/hats.md) và
> [phases.md](playbook/phases.md); file này chỉ ghi mục tiêu, nhịp làm việc, công cụ và những chỗ làm khác default.
> Sửa qua PR, ghi lý do và ngày.

## Goals

- **Product goal:** Giúp HR và quản lý ở doanh nghiệp nhỏ và vừa tại Việt Nam quản lý nhân viên, cơ cấu tổ chức, chấm
  công, nghỉ phép và lương trên một hệ thống, để nhân viên tự xem thông tin và gửi yêu cầu thay vì hỏi HR qua tin nhắn
  hay bảng tính.
- **Project type:** Product, theo bảng Project types trong [playbook](playbook/README.md)
- **Learning goals:**
  - Phân tích một domain có luật nghiệp vụ thật: phép năm, chấm công và lương, đối chiếu với Bộ luật Lao động; lập ma
    trận phân quyền cho nhiều vai trò.
  - Thiết kế data model giữ được luật nhất quán và dữ liệu theo thời gian: số dư phép không âm khi hai đơn được duyệt
    cùng lúc; chuyển phòng ban hay tăng lương có ngày hiệu lực, và xem lại được cơ cấu tổ chức tại một ngày bất kỳ.
  - Viết ADR so sánh ít nhất hai phương án thật cho mỗi quyết định khó đảo ngược.
  - Sau baseline: thiết kế tính năng AI như một component bình thường, có eval-lite.

## Cadence

- **Time budget:** khoảng 6 giờ mỗi ngày
- **Weekly review:** Chủ nhật hằng tuần
- **Target release:** chưa đặt; đặt sau khi baseline xong

| Milestone | Target date | Scope |
|---|---|---|
| Baseline | 2026-11-12 | Phase 1–3: phân tích và thiết kế chi tiết cho M1–M5 |
| M1 | — | Walking skeleton: đăng nhập, vai trò, hồ sơ nhân viên, cơ cấu tổ chức; chạy trên staging |
| M2 | — | Nghỉ phép |
| M3 | — | Chấm công |
| M4 | — | Lương và phúc lợi |
| M5 | — | Báo cáo và phân tích |
| M6 | — | Tính năng AI, theo Feature loop |

## Tools

| Purpose | Choice |
|---|---|
| Code and review | GitHub |
| Tracker and board | GitHub Issues + GitHub Projects ([board](https://github.com/users/pbaodev/projects/6)); label và Issue baseline tạo bằng `scripts/bootstrap-github.sh` |
| Agent access to tracker | `gh` CLI |
| AI agent | Claude Code, Codex |
| Diagrams | Mermaid trong Markdown |
| Hosting | Chọn ở Phase 3, dẫn ADR |
| Secrets | `.env` ở local; nơi lưu cho môi trường deploy chọn ở Phase 3 |

## Deviations from default

| Topic | Default | My choice | Reason | Effective |
|---|---|---|---|---|
| Phạm vi baseline | Baseline chỉ phân tích đủ cho các milestone đầu; module sau phân tích ở Feature loop ([phases.md](playbook/phases.md)) | Baseline phân tích và thiết kế chi tiết cho M1–M5 | Muốn luyện phân tích và thiết kế toàn hệ thống trước khi code; code có thể chậm hơn | 2026-10-29 |
| Agent đọc secret | Agent không đọc, không sửa secret ([hats.md](playbook/hats.md)) | Agent được đọc `.env` ở local; vẫn không sửa secret và không chép giá trị secret vào code, test, log, prompt hay PR | Secret hiện chỉ là giá trị dev ở local; xem lại khi có production | 2026-10-29 |

## Retro log

Ghi sau mỗi milestone. Cột cuối giúp nhìn lại những gì đã học được về phân tích và thiết kế.

| Milestone | Keep | Drop | Try | Learned about design | Date |
|---|---|---|---|---|---|
