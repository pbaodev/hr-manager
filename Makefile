.DEFAULT_GOAL := help
.PHONY: help setup check

# Cấu hình setup và check theo stack ở Phase 3, rồi ghi lệnh vào mục Commands của docs/build/SPEC.md.
# Dùng công cụ khác Make thì cập nhật mục đó và CI tương ứng.
help:
	@echo "Template chưa có lệnh setup hoặc kiểm tra ứng dụng."
	@echo "Cấu hình ở Phase 3; lệnh của dự án ghi tại mục Commands trong docs/build/SPEC.md."
	@echo "CI hiện chỉ kiểm tra link trong tài liệu."

setup:
	@echo "setup chưa được cấu hình. Thêm lệnh cài đặt thật hoặc dùng công cụ của dự án." >&2
	@exit 1

check:
	@echo "check chưa được cấu hình. Chưa chạy lint, kiểm kiểu hay test ứng dụng." >&2
	@exit 1
