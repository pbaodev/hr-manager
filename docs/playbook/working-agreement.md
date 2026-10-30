# Working agreement

Cách làm việc mặc định cho một người cùng AI agent. Chi tiết về nhánh, commit, CI và phát hành nằm ở
[git-workflow.md](git-workflow.md). Làm khác chỗ nào thì ghi vào [project.md](../project/project.md), không sửa file này. Các
default nhẹ về thủ tục nhưng chặt về bằng chứng: khi agent viết code nhanh, chỗ dễ hỏng là thiết kế bị bỏ qua và kết quả
không được thử thật.

## Tasks

- **Tracker:** Feature, Task, Bug, Spike và CR nằm trên tracker ghi ở `project.md`, và chỉ nằm ở đó; không chép danh
  sách việc sang file trong repo. Default là GitHub Issues, gom theo milestone, trạng thái theo một board GitHub
  Projects với các cột `Todo`, `Ready`, `In progress`, `In review`, `Done`. Issue chỉ sang `Ready` khi đạt Definition
  of Ready.
- **Feature and Task:** mỗi feature là một Issue Feature; việc cụ thể là Task, gắn làm sub-issue của Feature.
- **Baseline:** tài liệu Phase 0–3 là Issue trong milestone `Baseline`, tạo bằng `scripts/bootstrap-github.sh
  --baseline`. Một Issue tài liệu có thể đi qua nhiều PR.
- **Labels:** `type:*` theo mẫu Issue; `priority:must`, `priority:should`, `priority:could` theo priority của story
  trong [stories](../analysis/stories.md). Script bootstrap tạo sẵn các label này.
- Mỗi Task vừa một PR và xong trong một hoặc hai phiên làm việc.
- Tối đa một Feature và hai Task ở trạng thái `In progress`. Nhánh sống tối đa vài ngày.
- Cuối mỗi phiên làm việc, ghi điểm dừng và bước tiếp theo vào Issue đang làm. Thời gian làm dự án cá nhân thường rời
  rạc; ghi chú này giúp quay lại nhanh và cho agent đủ ngữ cảnh.
- Weekly review theo lịch trong `project.md`: xem board, chọn việc cho tuần tới, đọc error log khi đã có production.

**Definition of Ready**

- **Story:** đạt INVEST.
  - [ ] **Independent:** không bị chặn bởi story chưa xong; phụ thuộc còn lại đã ghi rõ.
  - [ ] **Negotiable:** ghi nhu cầu và giá trị, không áp sẵn giao diện hay cách làm.
  - [ ] **Valuable:** vế "để …" nêu được giá trị cụ thể cho actor.
  - [ ] **Estimable:** đủ thông tin để chia Task; câu hỏi `blocks-build` liên quan đã có trả lời.
  - [ ] **Small:** vừa một Feature, chia được thành vài Task, xong trong một milestone. Lớn hơn thì tách theo
    [analysis.md](analysis.md).
  - [ ] **Testable:** acceptance criteria kiểm được, có ít nhất một nhánh thất bại.
- **Feature:** các story đạt DoR; Analysis delta và Design delta đã merge, hoặc Issue ghi "Không đổi thiết kế" kèm lý
  do.
- **Task:** có mục tiêu, acceptance criteria kiểm được, link tới Feature và mục SPEC hoặc tài liệu thiết kế, non-goals.
- **Bug:** có bước tái hiện, kết quả mong đợi, kết quả thực tế và mức S1–S4 theo [testing.md](../build/testing.md).

## Branches and commits

- **Branch:** `<type>/<issue>-<short-desc>`, kebab-case tiếng Anh, ví dụ `feat/12-recurring-booking`. Type theo bảng
  commit type trong [git-workflow.md](git-workflow.md), cộng `spike`.
- **Commit và tiêu đề PR:** theo [Conventional Commits](https://www.conventionalcommits.org/). Phần `type(scope)` viết
  tiếng Anh, mô tả viết tiếng Việt, ví dụ `fix(booking): trả 409 thay vì 500 khi trùng lịch`. CI kiểm tiêu đề PR.
- **Liên kết:** PR ghi `Closes #123` để Issue tự đóng và chuyển sang `Done` khi merge. PR trung gian của một Issue tài
  liệu ghi `Refs #123`.

## Pull requests

- Mọi thay đổi vào `main` đi qua PR, kể cả khi làm một mình: CI chạy, agent review, và lịch sử giữ được lý do.
- Trước khi merge: cho AI review và sửa hết phát hiện mức Critical, Required; rồi tự đọc lại diff trên GitHub. Đọc
  trên một giao diện khác editor giúp thấy lỗi mà lúc viết bỏ qua.
- PR rủi ro cao chờ review nguội: để ít nhất vài giờ, tốt nhất là qua đêm, rồi đọc lại trước khi merge. Rủi ro cao là
  PR đụng tới tiền, quyền, dữ liệu nhạy cảm, migration, contract, prompt hoặc model.
- PR làm khác tài liệu thiết kế thì cập nhật tài liệu trong cùng PR, hoặc mở Issue và ghi vào mục Design impact.

## Merge

- **Squash merge:** mỗi PR thành một commit trên `main`; cần revert thì revert cả PR. Merge xong thì xóa nhánh.
- **Feature flag:** tính năng chưa xong vẫn merge từng PR nhỏ, đặt sau flag đang tắt, thay vì giữ nhánh sống lâu.
- **Branch protection cho `main`:** bắt buộc qua PR; CI xanh và nhánh đã cập nhật theo `main`; chặn force-push và chặn
  xóa nhánh. Không bật yêu cầu người duyệt, vì GitHub không cho tự duyệt PR của mình.

## Definition of Done

- [ ] Đạt acceptance criteria của task và đã chạy thử thật, không chỉ chạy test.
- [ ] Hành vi mới có test, và test đó fail nếu bỏ phần sửa.
- [ ] `make check` xanh.
- [ ] Chỉ sửa trong phạm vi task; không để lại code chết hay secret.
- [ ] Tài liệu thiết kế, SPEC, config và `.env.example` khớp với code.
- [ ] Có bằng chứng theo loại thay đổi trong bảng dưới; PR ghi rõ phần chưa kiểm.

| Change | Evidence |
|---|---|
| Logic hoặc luật nghiệp vụ | Test theo `BR-xxx` và `EC-xxx` liên quan |
| Interface hoặc schema | Test contract; migration chạy được trên dữ liệu có sẵn; kiểm tương thích ngược |
| Giao diện | Thử luồng sử dụng; các trạng thái loading, empty, error; accessibility |
| Hành vi AI | Eval-lite trước và sau, theo [ai-components.md](ai-components.md) |
| Tài liệu | Link dùng được, sơ đồ render được, nội dung khớp với code |

**Story** xong khi mọi Task đã merge, acceptance criteria đạt khi thử trên staging (hoặc local khi không có staging),
và dòng của story trong Traceability của [SPEC](../build/SPEC.md) đã sang `Implemented`. Story chuyển sang `Tested` và
`Accepted` ở release gate, theo [phases.md](phases.md).

## Other defaults

- **Decisions:** ghi vào Issue hoặc ADR. Kết luận từ chat với AI thì tóm tắt và dẫn link về đó.
- **Dependencies:** ghi lý do trong PR và khóa phiên bản. Thư viện ảnh hưởng tới kiến trúc, như framework, ORM, auth
  hay hosting, cần ADR.
- **Flaky tests:** tính là bug; sửa trong ngày hoặc tách khỏi bộ test chính. Mỗi test dùng dữ liệu riêng.
- **Production bugs:** mở Issue trong ngày, ghi mức S1–S4 theo [testing.md](../build/testing.md).
- **Releases:** mỗi milestone đóng bằng một tag SemVer và một mục trong [CHANGELOG](../../CHANGELOG.md), theo mục
  Releases trong [git-workflow.md](git-workflow.md).
- **Changing this agreement:** sửa mục Deviations trong `project.md`, ghi lý do và ngày có hiệu lực.

## Variations

- Experiment: làm trên nhánh hoặc repo riêng, không cần PR; kết luận ghi vào Issue Spike.
- Có thêm người cùng làm: bật yêu cầu một người duyệt và thêm CODEOWNERS; review nguội vẫn áp dụng cho tài liệu.
- Dùng tracker khác GitHub Issues: giữ các quy tắc, chuyển mẫu Issue sang công cụ đó và ghi vào `project.md`.
