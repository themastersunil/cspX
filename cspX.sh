#!/bin/bash

# Function to get the CSP header from a URL
get_csp_header() {
    local url=$1
    curl -m 3 -si "$url" -L | grep -iE "Content-Security-Policy:|content-security-policy-report-only:" | tr -d '\r'
}

# Main function to call get_csp_header and process the URL
main() {
    local url=$1
    if [ -z "$url" ]; then
        echo "Usage: $0 <url>"
        exit 1
    fi

    get_csp_header "$url" | tr " /;,=" '\n' | tr A-Z a-z| grep -Ea '\.'
}

# Call the main function with all script arguments
main "$@"
