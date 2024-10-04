#!/bin/bash

# Path to the commit message file
commit_msg_file="/home/ubuntu/test-repo/.git/COMMIT_EDITMSG"

# Function to display options and prompt for input
prompt_for_input() {

    # Prompt for Module/Functional Category selection
    echo "A. Select Module/Functional Category:"
    echo "1. Account & User Management"
    echo "2. Account Management"
    echo "3. Allocation Management"
    echo "4. Allocation/Sourcing Management"
    echo "5. Certificate Configuration"
    echo "6. Contract Management"
    echo "7. Customer Management"
    echo "8. Dashboard"
    echo "9. Issue Reporting"
    echo "10. Logistic Management"
    echo "11. Product & Configuration"
    echo "12. Production Management"
    echo "13. Shipment Dashboard"
    echo "14. Shipment Management"
    echo "15. Sourcing & Contract Management"
    echo "16. Spatial Monitoring And Analysis"
    echo "17. Supplier Profile Management"
    echo "18. Task & Workflow Management"
    echo "19. Tenant Management"
    echo "20. Traceability Management"
    echo "21. Notification Management"
    echo "22. Others"
    read -p "Select Module/Functional Category (1-22): " module

    # Prompt for Business Unit selection
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
    echo "11. Tenant Admin"
    read -p "Select Business Unit (1-11): " business_unit

    # Prompt for Use Case ID
    read -p "C. Enter Use Case ID: " use_case_id

    # Prompt for JIRA Issue No
    read -p "D. Enter JIRA Issue No: " jira_issue_no

    # Prompt for Change Summary
    echo "E. Provide Change Summary (max 50 words):"
    echo "Please provide a brief description of your changes."
    read -p "Change Summary: " change_summary

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

    echo "Commit message has been generated and written to $commit_msg_file"
}

# Execute the function to start the process
prompt_for_input
