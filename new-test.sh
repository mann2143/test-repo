#!/bin/bash

# Path to the commit message file
commit_msg_file="/home/ubuntu/test-repo/.git/COMMIT_EDITMSG"

# Function to display options and prompt for input
prompt_for_input() {
    echo "A. Select Module/Functional Category:"
    echo "1. Account & User Management"
    echo "2. Allocation Management"
    echo "3. Allocation/Sourcing Management"
    echo "4. Certificate Configuration"
    echo "5. Contract Management"
    echo "6. Customer Management"
    echo "7. Dashboard"
    echo "8. Issue Reporting"
    echo "9. Logistic Management"
    echo "10. Product & Configuration"
    echo "11. Production Management"
    echo "12. Shipment Dashboard"
    echo "13. Shipment Management"
    echo "14. Sourcing & Contract Management"
    echo "15. Spatial Monitoring And Analysis"
    echo "16. Supplier Profile Management"
    echo "17. Task & Workflow Management"
    echo "18. Tenant Management"
    echo "19. Traceability Management"
    echo "20. Notification Management"
    echo "21. Others"
    read -p "Select Module/Functional Category (1-21): " module

    echo "B. Select Business Unit:"
    echo "1. Tenant"
    echo "2. Customer"
    echo "3. KCP"
    echo "4. Mill"
    echo "5. Mill/KCP"
    echo "6. Platform Admin"
    echo "7. Platform Management"
    echo "8. Refinery"
    echo "9. Supply Chain Department"
    echo "10. Tenant Admin"
    read -p "Select Business Unit (1-10): " business_unit

    read -p "C. Enter Use Case ID: " use_case_id
    read -p "D. Enter JIRA Issue No: " jira_issue_no
    read -p "E. Provide Change Summary (max 50 words): " change_summary

    # Check word count for change summary
    word_count=$(echo $change_summary | wc -w)
    if [ "$word_count" -gt 50 ]; then
        echo "Error: Change Summary exceeds 50 words."
        exit 1
    fi

    # Get current branch name
    branch_name=$(git rev-parse --abbrev-ref HEAD)

    # Check if branch name contains JIRA issue number (case insensitive)
    if [[ ! "$branch_name" =~ "$jira_issue_no" ]]; then
        echo "Error: Branch name must include the JIRA Issue No ($jira_issue_no) in a case-insensitive format."
        exit 1
    fi

    # Construct the commit message
    commit_message="[$jira_issue_no] - Module: $module, Business Unit: $business_unit, Use Case: $use_case_id, Summary: $change_summary"

    # Write the commit message to the commit message file
    echo "$commit_message" > "$commit_msg_file"
}

# Execute the function to start the process
prompt_for_input

