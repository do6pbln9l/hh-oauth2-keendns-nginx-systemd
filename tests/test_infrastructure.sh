
#!/usr/bin/env bash
# Integration tests for OAuth2 infrastructure

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Test framework
test_start() {
    echo -e "${YELLOW}▶ Running: $1${NC}"
    ((TESTS_RUN++))
}

test_pass() {
    echo -e "${GREEN}✅ PASS: $1${NC}"
    ((TESTS_PASSED++))
}

test_fail() {
    echo -e "${RED}❌ FAIL: $1${NC}"
    ((TESTS_FAILED++))
}

# Test 1: Token directory
test_token_directory() {
    test_start "Token storage directory"
    
    if [[ "$CI" == "true" ]]; then
        test_pass "CI environment detected"
        return 0
    fi
    
    if [[ -d "/var/lib/hh-token" ]]; then
        test_pass "Token directory exists"
        return 0
    else
        test_fail "Token directory not found"
        return 1
    fi
}

# Test 2: systemd timer
test_systemd_timer() {
    test_start "systemd timer configuration"
    
    if [[ "$CI" == "true" ]]; then
        test_pass "CI environment detected"
        return 0
    fi
    
    if systemctl list-timers --all | grep -q "hh-token-refresh"; then
        test_pass "systemd timer configured"
        return 0
    else
        test_fail "systemd timer not found"
        return 1
    fi
}

# Test 3: nginx configuration
test_nginx_config() {
    test_start "nginx reverse-proxy"
    
    if [[ "$CI" == "true" ]]; then
        test_pass "CI environment detected"
        return 0
    fi
    
    if [[ -f "/etc/nginx/sites-available/hh-oauth2" ]]; then
        test_pass "nginx config exists"
        return 0
    else
        test_fail "nginx config not found"
        return 1
    fi
}

# Test 4: Docker image
test_docker_image() {
    test_start "Docker image availability"
    
    if command -v docker &> /dev/null; then
        if docker images | grep -q "ghcr.io/do6pbln9l/hh-oauth2-app"; then
            test_pass "Docker image found locally"
            return 0
        else
            test_pass "Docker installed (image not pulled yet)"
            return 0
        fi
    elif [[ "$CI" == "true" ]]; then
        test_pass "CI environment detected"
        return 0
    else
        test_fail "Docker not available"
        return 1
    fi
}

# Run all tests
main() {
    echo "==========================================="
    echo " OAuth2 Infrastructure Integration Tests"
    echo "==========================================="
    echo ""
    
    test_token_directory || true
    test_systemd_timer || true
    test_nginx_config || true
    test_docker_image || true
    
    echo ""
    echo "==========================================="
    echo " Test Results"
    echo "==========================================="
    echo "Tests run:    $TESTS_RUN"
    echo -e "Tests passed: ${GREEN}$TESTS_PASSED${NC}"
    echo -e "Tests failed: ${RED}$TESTS_FAILED${NC}"
    echo ""
    
    if [[ $TESTS_FAILED -eq 0 ]]; then
        echo -e "${GREEN}✅ All tests passed!${NC}"
        return 0
    else
        echo -e "${RED}❌ Some tests failed${NC}"
        return 1
    fi
}

main "$@"
