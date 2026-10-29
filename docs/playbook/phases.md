# Phases

Sáu phase từ setup tới vận hành, dùng chung một khung: Goal, Input, Output, Hat, Exit criteria, Activities và
Variations. Bảng tóm tắt nằm ở [playbook/README.md](README.md).

- **Default:** con số và thứ tự trên trang này là mặc định cho một người làm dự án vừa để học vừa để chạy thật. Dự án
  chỉ ghi vào [project.md](../project.md) những chỗ làm khác.
- **Hat** là mũ trong [hats.md](hats.md): Analyst, Architect, Developer, Ops. Mỗi lúc chỉ đội một mũ.
- **Baseline:** Phase 0–3 làm một lần để có yêu cầu, domain và thiết kế đã `Accepted`. Từ Phase 4, feature mới đi
  theo Feature loop; thay đổi những gì đã chốt đi theo [change-control.md](change-control.md).
- **Exit criteria** chặn việc chốt, không chặn việc bắt đầu. Việc của phase sau có thể làm nháp từ sớm. Mỗi dòng là
  một checkbox; tick trong Issue của deliverable hoặc của milestone, kèm link bằng chứng.
- **Client delivery:** khi dự án giao cho một bên nhận, làm thêm các mục ghi "Client delivery" trong Exit criteria và
  Variations.

## Phase 0 — Setup

**Goal:** Có repo, tracker và nhịp làm việc dùng được trước khi viết tài liệu đầu tiên.

- **Input:** Template này, ý tưởng ban đầu.
- **Output:** [project.md](../project.md), label và branch protection cho `main`, milestone `Baseline` cùng Issue cho
  deliverable Phase 0–3, board trên GitHub Projects.
- **Hat:** Ops.

**Exit criteria**

- [ ] `project.md` đã merge, có Project type, quỹ thời gian và lịch weekly review.
- [ ] `main` được bảo vệ; check `docs`, `contract`, `pr-title` là required và chạy trên mỗi PR.
- [ ] Milestone `Baseline` có Issue cho các deliverable cần theo Project type; Issue không áp dụng đã đóng kèm lý do.
- [ ] Board có các cột `Todo`, `Ready`, `In progress`, `In review`, `Done`.

**Activities**

1. Tạo repo từ template và push lên GitHub. Chạy `scripts/bootstrap-github.sh --protect --baseline`: tạo label, chỉ
   cho squash merge, bật branch protection cho `main`, tạo milestone `Baseline` và Issue cho deliverable. Script không
   bật yêu cầu người duyệt, vì GitHub không cho tự duyệt PR của mình.
2. Tạo board GitHub Projects với các cột `Todo`, `Ready`, `In progress`, `In review`, `Done`, và bật workflow có sẵn
   để issue mới tự vào `Todo`.
3. Điền `project.md`: mục tiêu sản phẩm, mục tiêu học, quỹ thời gian mỗi tuần, lịch weekly review, công cụ.
4. Đọc [working-agreement.md](working-agreement.md); ghi vào `project.md` những chỗ làm khác default.
5. Chọn nơi lưu secret. Dịch vụ trả phí nào cũng có API key riêng và giới hạn chi tiêu.

**Variations**

- Experiment: chạy script không có `--protect` và `--baseline`; bỏ board; dùng một Issue Spike.

## Phase 1 — Discovery

**Goal:** Hiểu đúng bài toán, thử phần rủi ro nhất và quyết định có đáng làm không.

- **Input:** Ý tưởng; người dùng tiềm năng, kể cả chính mình.
- **Output:** [brief](../brief.md), [questions](../questions.md), Issue Spike cho rủi ro lớn, ADR khi spike dẫn tới
  quyết định khó đảo ngược.
- **Hat:** Analyst.

**Exit criteria**

- [ ] Brief `Accepted`; mục Decision ghi `Go`, `Pivot` hoặc `Stop`.
- [ ] Rủi ro kỹ thuật lớn nhất đã được spike, hoặc brief ghi lý do chưa cần.
- [ ] Mọi câu hỏi `blocks-design` đã có người hoặc nguồn để hỏi.

**Activities**

1. Ghi nguồn ý tưởng vào mục Origin của brief. Có đề bài hay yêu cầu gốc thì chép nguyên văn và không sửa về sau.
2. Viết mục Problem trước mục Solution: ai gặp vấn đề gì, trong hoàn cảnh nào, hiện đang xoay xở ra sao.
3. Xem các giải pháp có sẵn và ghi vào mục Alternatives vì sao vẫn tự làm. "Để học" là lý do hợp lệ; ghi thẳng ra.
4. Khi sản phẩm không chỉ cho mình: nói chuyện với 2–3 người dùng tiềm năng. Câu hỏi ghi vào `questions.md` với mã
   `Q-xxx` và mức chặn.
5. Liệt kê 3–5 rủi ro lớn nhất về sản phẩm, kỹ thuật và thời gian vào mục Risks. Mỗi rủi ro kỹ thuật lớn có một Issue
   Spike theo [mẫu](../../.github/ISSUE_TEMPLATE/spike.md), có time box.
6. Làm spike: code để bỏ đi, không merge vào `main`. Kết quả ghi vào Issue; quyết định khó đảo ngược thì viết ADR.
7. Hoàn thiện brief: scope, success metrics, decision.

**Guidelines**

- Brief giữ trong một trang. Điều chưa biết thì ghi `(assumption)`, không bỏ trống.
- Spike trả lời một câu hỏi cụ thể. Spike không có câu hỏi sẽ thành prototype và kéo dài không có điểm dừng.
- Kết quả spike đủ để chọn hướng, chưa phải bằng chứng là sản phẩm sẽ chạy tốt.

**Variations**

- Personal tool chỉ mình dùng: bỏ bước 4.
- Experiment: brief một đoạn, một Issue Spike, kết thúc ở phase này.

## Phase 2 — Analysis

**Goal:** Mô tả hệ thống phải làm gì, theo luật nào và tốt tới mức nào, đủ rõ để thiết kế mà chưa chọn công nghệ.

- **Input:** Brief, questions, kết quả spike.
- **Output:** [requirements](../requirements.md), [stories](../stories.md), [domain](../domain.md),
  [UI flow](../ui-flow.md) khi có giao diện, `questions.md` đã cập nhật.
- **Hat:** Analyst.

**Exit criteria**

- [ ] Requirements, stories và domain `Accepted` sau review nguội theo Analysis checklist trong
  [analysis.md](analysis.md).
- [ ] Mỗi story `Must` đạt Definition of Ready trong [working-agreement.md](working-agreement.md), gồm INVEST.
- [ ] Có từ hai vai trò người: ma trận phân quyền phủ mọi vai trò và mọi thao tác trong story.
- [ ] 3–5 quality attribute quan trọng nhất có số đo và cách kiểm chứng.
- [ ] Mọi câu hỏi `blocks-design` đã có trả lời hoặc thành assumption.
- [ ] Không còn business rule `Disputed` trong phạm vi baseline.
- [ ] Client delivery: bên nhận đã xác nhận mục Sign-off trong requirements.

**Activities**

Cách làm từng bước nằm ở [analysis.md](analysis.md).

1. Liệt kê actor, gồm người và hệ thống ngoài, cùng mục tiêu và quyền của từng actor. Có từ hai vai trò người thì lập
   ma trận phân quyền.
2. Viết user story `US-xxx` cho phần In của brief vào `stories.md`; mỗi story có acceptance criteria và priority.
3. Story có nhiều bước, nhiều nhánh hoặc tác động khó đảo ngược thì viết thêm use case `UC-xxx`. Mỗi exception flow
   thành edge case hoặc business rule.
4. Mô hình domain theo thứ tự: glossary, entity và quan hệ, vòng đời, business rule `BR-xxx`, edge case `EC-xxx`. Con
   số trong luật đưa vào bảng Parameters.
5. Viết quality attribute `QA-xxx` dạng scenario có số đo và cách kiểm chứng, rồi xếp theo độ quan trọng và độ khó.
   Các dòng đứng đầu là architecture driver của Phase 3.
6. Có giao diện: viết `ui-flow.md` ở mức wireframe; mỗi màn hình dẫn tới `US-xxx`.
7. Review nguội và AI phản biện theo Analysis checklist; sửa xong thì chuyển sang `Accepted`.

**Guidelines**

- Requirements và domain không ghi framework, DB hay dịch vụ dùng để xây hệ thống. Hệ thống ngoài mà sản phẩm phải nối
  tới là actor và được ghi tên. Ràng buộc công nghệ có thật thì ghi ở mục Scope của brief.
- Luật do AI gợi ý ghi `Assumed` cho tới khi có nguồn xác nhận.
- Ý tưởng kỹ thuật nảy ra lúc phân tích thì ghi vào một Issue để xem ở Phase 3, không đưa vào requirements.
- Baseline chỉ cần đủ cho các milestone đầu. Feature sau được phân tích ở Feature loop.

**Variations**

- Personal tool: chỉ viết use case cho luồng có tác động khó đảo ngược; 1–3 quality attribute.
- Domain chủ yếu là CRUD: bỏ mục aggregate; chỉ vẽ vòng đời cho entity có trạng thái thật.
- Sản phẩm không có giao diện: bỏ bước 6.
- Client delivery: sau bước 7, bên nhận đọc requirements, stories và domain rồi xác nhận mục Sign-off. Từ đó, đổi story
  hay luật đã chốt đi theo [change-control.md](change-control.md).

## Phase 3 — Design

**Goal:** Chọn cấu trúc hệ thống đáp ứng requirements và quality attribute, ghi lý do của từng quyết định khó đảo
ngược, và chuẩn bị đủ để code theo slice.

- **Input:** Output của Phase 2.
- **Output:** [ARCHITECTURE.md](../../ARCHITECTURE.md); [components](../design/components.md),
  [data](../design/data.md), [api](../design/api.md) và `contracts/openapi.yaml`, [flows](../design/flows.md),
  [ui](../design/ui.md) khi có giao diện, [ai](../design/ai.md) khi có tính năng AI; [ADR](../decisions/README.md);
  [SPEC](../SPEC.md); [conventions](../conventions/README.md); `make setup`, `make check`, CI, staging;
  [setup](../setup.md); khung [testing](../testing.md).
- **Hat:** Architect.

**Exit criteria**

- [ ] Qua Design review checklist trong [design.md](design.md), gồm review nguội và AI phản biện.
- [ ] ADR về architecture style, stack, lưu trữ dữ liệu, auth và hosting đã `Accepted`.
- [ ] Schema và API contract đã merge; check `contract` xanh.
- [ ] Migration đầu tiên chạy được trên DB trống; seed chạy được.
- [ ] SPEC v1.0 `Accepted`; Traceability phủ mọi story `Must` và mọi architecture driver, các dòng ở Status `Designed`.
- [ ] `make check` chạy được và là một job trong CI.
- [ ] Clone mới trên máy sạch hoặc container, chạy được theo [setup](../setup.md) trong 30 phút; ghi vào mục Verified.
- [ ] Staging deploy được một bản rỗng.

**Activities**

Cách làm từng bước nằm ở [design.md](design.md).

1. Vẽ C4 Context: hệ thống, actor và hệ thống ngoài. Actor lấy từ requirements.
2. Ghi architecture drivers: các quality attribute đứng đầu và ràng buộc. Mỗi driver có ít nhất một tactic.
3. Chọn architecture style và stack, viết ADR. Default cho một người là modular monolith.
4. Vẽ C4 Container: ứng dụng, DB, hàng đợi, dịch vụ ngoài và cách chúng giao tiếp.
5. Thiết kế dữ liệu từ domain: quy ước, ERD, constraint cho invariant, index cho truy vấn chính. Viết migration đầu
   tiên và seed.
6. Thiết kế API từ user story: operation, lỗi, auth. Contract đặt ở `contracts/openapi.yaml`; CI lint bằng job
   `contract`.
7. Vẽ C4 Component cho container có logic đáng kể: module và dependency rule.
8. Có giao diện: chốt design system, trạng thái màn hình, định dạng và accessibility trong
   [design/ui.md](../design/ui.md).
9. Vẽ sequence diagram cho mỗi luồng chính và mỗi use case, đi qua từng bước bằng container, API và dữ liệu đã thiết
   kế. Chỗ không đi qua được là lỗ hổng thiết kế.
10. Chốt cross-cutting concerns: auth, validation, xử lý lỗi, log, config, thời gian và timezone. Ghi các mối đe dọa
    chính vào mục Threats của ARCHITECTURE.
11. Có tính năng AI: thiết kế như một component theo [ai-components.md](ai-components.md).
12. Viết SPEC: module map, Traceability, lệnh, test strategy và boundaries cho agent.
13. Cấu hình `make setup`, `make check` và CI theo stack; viết [setup.md](../setup.md) và thử trên máy sạch. Thêm job
    CI mới vào required status checks bằng `scripts/bootstrap-github.sh --protect`, và bỏ check của job đã xóa; nếu
    không, PR sẽ chờ một check không bao giờ chạy. Dựng staging và pipeline deploy.
14. Tạo khung [testing.md](../testing.md): môi trường và dữ liệu test. Ca thủ công thêm dần ở Feature loop.
15. Ghi vào conventions những quy tắc mà linter và formatter không tự kiểm được.
16. Review nguội và AI phản biện theo Design review checklist; sửa xong thì chuyển sang `Accepted`.

**Guidelines**

- Đi từ ngoài vào trong: Context, Container, rồi Component. Không vẽ tầng code; code là nguồn của tầng đó.
- Mỗi quyết định khó đảo ngược có ADR với ít nhất hai phương án thật.
- Assumption là con số (ngưỡng, phí, thời hạn) thì đặt trong config thay vì hard-code.
- Thiết kế đủ cho baseline. Phần chỉ có ở milestone sau thì thiết kế ở Feature loop.

**Variations**

- Personal tool: ARCHITECTURE chỉ có Context và Container; trong `design/` chỉ giữ `data.md` và `api.md` khi có; bỏ
  staging.
- Không có API qua mạng: `api.md` ghi interface chính như CLI, event hoặc module public; bỏ `contracts/` và job
  `contract`.
- Không có giao diện: bỏ `design/ui.md` và bước 8.
- Không có tính năng AI: bỏ `design/ai.md` và bước 11.

## Phase 4 — Build & Release

**Goal:** Làm theo vertical slice; mỗi feature mới đi qua mini Analysis + Design trước khi code; mỗi milestone kết thúc
bằng một bản phát hành.

- **Input:** Baseline: requirements, stories, domain, tài liệu thiết kế và SPEC v1.0.
- **Output:** Code đã merge, tài liệu cập nhật cùng code, ca thủ công và Release test log trong
  [testing](../testing.md), bản phát hành có tag, [CHANGELOG](../../CHANGELOG.md).
- **Hat:** Developer; đổi sang Analyst hoặc Architect ở Feature loop, sang Ops khi phát hành.

**Exit criteria (release gate)**

- [ ] Mọi story của milestone ở `Accepted` trong Traceability: test liên quan pass trên staging và đã nghiệm thu theo
  acceptance criteria.
- [ ] `make check` và E2E xanh.
- [ ] Quality attribute mà milestone đụng tới đã được đo lại; kết quả ghi ở Release test log.
- [ ] Không còn bug S1, S2 đang mở.
- [ ] Tài liệu thiết kế, SPEC, setup và runbook khớp với code.
- [ ] Rollback đã sẵn sàng.

**Milestone planning**

1. Chọn story cho milestone theo priority và rủi ro. Milestone đầu là walking skeleton: luồng mỏng nhất chạy
   end-to-end trên staging và đi qua mọi container.
2. Mỗi story hoặc nhóm story nhỏ thành một Issue Feature theo [mẫu](../../.github/ISSUE_TEMPLATE/feature.md).
3. Feature chia thành Task, mỗi Task vừa một PR, gắn làm sub-issue của Feature và đưa vào board.

**Feature loop**

Áp dụng cho mỗi Issue Feature, kể cả feature trong baseline.

1. **Analysis delta** (Analyst): thêm hoặc sửa US, UC, BR, EC, QA trong stories, requirements và domain.
2. **Design delta** (Architect): ghi phần thiết kế bị ảnh hưởng (data, API, component, flow, AI); viết ADR nếu có quyết
   định khó đảo ngược.
3. **Review delta:** chạy phần liên quan của Analysis checklist và Design review checklist. Feature đụng data, API hoặc
   kiến trúc thì review nguội.
4. Cập nhật Traceability trong SPEC với Status `Designed`; story cần thử tay thì thêm ca `TC-xxx` vào
   [testing.md](../testing.md). Chia Task.
5. Làm từng Task theo Task loop. Tài liệu ở bước 1–2 merge trong PR đầu tiên của feature hoặc một PR riêng trước đó.

Feature chỉ đụng một module và không đổi data, API hay luật thì ghi "Không đổi thiết kế" kèm lý do trong Issue, rồi
sang bước 4.

**Task loop**

1. Nhận task, chuyển sang `In progress`, tạo nhánh từ `main`.
2. Đọc task, mục SPEC, tài liệu thiết kế liên quan và convention. Chỉ sửa trong phạm vi task; viết test kèm theo.
3. Chạy `make check`. Task đụng phần AI thì chạy eval-lite trước và sau khi sửa.
4. Mở PR theo [mẫu PR](../../.github/PULL_REQUEST_TEMPLATE.md). Cho AI review và sửa hết mức Critical, Required; rồi
   tự đọc lại diff trên GitHub. Chi tiết ở [git-workflow.md](git-workflow.md).
5. PR rủi ro cao chờ review nguội trước khi merge, theo [working-agreement.md](working-agreement.md).
6. Squash merge. Staging tự deploy; task tự chuyển sang `Done` nhờ `Closes #123` trong PR.
7. Cuối mỗi phiên làm việc, ghi điểm dừng và bước tiếp theo vào Issue đang làm.

Code cần làm khác thiết kế thì dừng và đổi sang mũ Architect: hoặc sửa code theo thiết kế, hoặc cập nhật thiết kế (và
ADR nếu cần) trong cùng PR và ghi rõ trong mục Design impact. Không để code và thiết kế lệch nhau.

**Milestone close**

1. Mọi task đã merge; staging chạy bản mới nhất.
2. Chạy test tự động và ca thủ công trong [testing.md](../testing.md) trên staging; story pass chuyển Traceability
   sang `Tested`.
3. Nghiệm thu với mũ Analyst theo acceptance criteria; story đạt chuyển sang `Accepted`. Lỗi mở
   [Issue Bug](../../.github/ISSUE_TEMPLATE/bug.md) kèm mức S1–S4.
4. Khi có người dùng khác: cho 1–3 người thử theo kịch bản; góp ý ghi thành Issue.
5. Release gate theo Exit criteria ở trên; ghi kết quả vào Release test log.
6. Phát hành theo mục Releases trong [git-workflow.md](git-workflow.md): backup, cập nhật CHANGELOG, deploy, smoke
   test, gắn tag. Có sự cố thì rollback theo [runbook](../runbook.md).
7. Retro: ghi vào Retro log của `project.md` điều nên giữ, nên bỏ, nên thử và điều học được về thiết kế.

**Guidelines**

- Nghiệm thu bằng thử thật, không chỉ nhìn test xanh.
- Khi báo kết quả, ghi rõ môi trường: `local`, `staging` hay `production`.
- Thời gian làm rời rạc thì chia Task nhỏ tới mức xong trong một hoặc hai phiên.

**Variations**

- Personal tool không có staging: release gate chạy ở local, sau đó smoke test trên production.
- Phát hành liên tục: release gate chạy tự động ở mỗi lần deploy production thay vì cuối milestone.
- Có deadline cố định: chia milestone thành iteration 1–2 tuần, ước lượng Task trên tracker. Giữ tỷ lệ gợi ý: phân
  tích và thiết kế khoảng 1/3 thời gian, code 1/3, test và phát hành phần còn lại.
- Client delivery: milestone cuối phát hành `vX.Y.Z-rc.N` lên staging để bên nhận chạy ca nghiệm thu. Story chỉ sang
  `Accepted` khi bên nhận xác nhận Acceptance sign-off trong [testing.md](../testing.md). Sau bản chính thức, làm
  Handover ở Phase 5.

## Phase 5 — Operate & Evolve

**Goal:** Giữ hệ thống chạy, phát hiện lỗi sớm, giữ thiết kế khớp với code và rút kinh nghiệm.

- **Input:** Bản production đầu tiên. Phase này chạy song song với Phase 4; phần setup chuẩn bị từ Phase 3.
- **Output:** Error tracking, uptime check, backup, [runbook](../runbook.md), [user guide](../user-guide.md) khi có
  người dùng khác, [handover](../handover.md) khi Client delivery, ADR mới hoặc `Superseded`, retro.
- **Hat:** Ops; Architect cho việc kiểm design drift.

**Exit criteria**

Không có, đây là vòng lặp. Trước bản production đầu tiên:

- [ ] Error tracking và backup đã chạy.
- [ ] Runbook có deploy, rollback, khôi phục backup và rotate key.
- [ ] Rollback và khôi phục đã thử ít nhất một lần; ngày ghi ở cột Last tested của runbook.
- [ ] Có người dùng khác: user guide phủ các việc chính.

**Setup**

1. Error tracking và log. Log không chứa dữ liệu nhạy cảm hay secret.
2. Uptime check, cảnh báo về email hoặc điện thoại.
3. Backup tự động cho dữ liệu; theo dõi chi phí hạ tầng và dịch vụ trả phí.
4. Runbook ngắn theo [mẫu](../runbook.md): deploy, rollback, khôi phục backup, rotate key.

**Recurring**

| Việc | Hat | Cadence |
|---|---|---|
| Đọc error log, uptime và chi phí; mở Bug khi cần | Ops | Hằng tuần, ở weekly review |
| Kiểm design drift: ARCHITECTURE, `design/` và SPEC còn khớp code không; lệch thì sửa tài liệu hoặc mở Issue | Architect | Mỗi milestone |
| Xem ADR nào đã chạm điều kiện trong mục Revisit when | Architect | Mỗi milestone |
| Lỗi hành vi AI trên production: ẩn danh rồi thêm vào smoke set | Developer | Mỗi khi có lỗi |
| Cập nhật dependency, vá lỗ hổng bảo mật | Developer | Hằng tháng |
| Thử khôi phục từ backup | Ops | Mỗi quý |

**Incident**

- Severe, tức S1 trong [testing.md](../testing.md) (production sập, mất hoặc lộ dữ liệu, sai tiền hoặc sai quyền):
  giảm ảnh hưởng trước bằng rollback, tắt tính năng hoặc thu hồi key; tìm nguyên nhân sau. Trong 48 giờ, viết
  postmortem ngắn vào Issue: chuyện gì xảy ra, vì sao, sửa gì để không lặp lại. Nguyên nhân nằm ở thiết kế thì cập
  nhật thiết kế hoặc viết ADR.
- Normal, tức S2–S4: mở Issue Bug trong ngày; S2 sửa trong milestone hiện tại, S3 và S4 xếp theo priority.

**Variations**

- Personal tool: chỉ cần backup và runbook rollback.
- Experiment: bỏ qua phase này.
- Client delivery: sau bản phát hành cuối, làm Handover theo [handover.md](../handover.md). Xong khi bên nhận tự
  deploy được một lần chỉ bằng tài liệu; mọi tài liệu `Accepted` và khớp code tại tag; việc còn lại đều là Issue có
  `priority:*`; hai bên đã xác nhận Sign-off.
