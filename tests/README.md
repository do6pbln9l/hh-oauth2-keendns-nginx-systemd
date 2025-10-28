
# 🧪 Integration Tests

Automated tests for OAuth2 infrastructure components.

## 🚀 Running Tests Locally

```

chmod +x tests/test_infrastructure.sh
./tests/test_infrastructure.sh

```

## 📊 Test Coverage

- ✅ Token storage directory (`/var/lib/hh-token`)
- ✅ systemd timer configuration (`hh-token-refresh.timer`)
- ✅ nginx reverse-proxy (`/etc/nginx/sites-available/hh-oauth2`)
- ✅ Docker image availability (`ghcr.io/do6pbln9l/hh-oauth2-app`)

## 📈 Expected Output

```

===========================================
OAuth2 Infrastructure Integration Tests
===========================================

▶ Running: Token storage directory
✅ PASS: Token directory exists

▶ Running: systemd timer configuration
✅ PASS: systemd timer configured

▶ Running: nginx reverse-proxy
✅ PASS: nginx config exists

▶ Running: Docker image availability
✅ PASS: Docker image found locally

===========================================
Test Results
===========================================
Tests run:    4
Tests passed: 4
Tests failed: 0

✅ All tests passed!

```

## 🌐 CI/CD Integration

Tests run automatically in GitHub Actions on every push to `main` branch. In CI environment, system-specific checks are skipped.

## 📝 Adding New Tests

1. ✏️ Create test function in `test_infrastructure.sh`
2. 🏷️ Follow naming convention: `test_<component_name>`
3. 🔧 Use `test_start`, `test_pass`, `test_fail` helpers
4. ➕ Add test call to `main()` function

## ⚙️ Test Environment Variables

- 🔐 `CI=true` - Skips system-specific checks (for GitHub Actions)

## 💡 Pro Tips

- Run tests before each commit to catch issues early
- Use `CI=true` locally to simulate GitHub Actions environment
- Check `journalctl -u hh-token-refresh.timer` for systemd logs
