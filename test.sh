#!/bin/bash

# Path to the commit message file
commit_msg_file="/home/ubuntu/test-repo/.git/COMMIT_EDITMSG"

# Function to display options and prompt for input
prompt_for_input() {
    # Step 1: Select Module/Functional Category
    echo "A. Select Module/Functional Category:"
    options=("Account & User Management"
             "Account Management"
             "Allocation Management"
             "Allocation/Sourcing Management"
             "Certificate Configuration"
             "Contract Management"
             "Customer Management"
             "Dashboard"
             "Issue Reporting"
             "Logistic Management"
             "Product & Configuration"
             "Production Management"
             "Shipment Dashboard"
             "Shipment Management"
             "Sourcing & Contract Management"
             "Spatial Monitoring And Analysis"
             "Supplier Profile Management"
             "Task & Workflow Management"
             "Tenant Management"
             "Traceability Management"
             "Notification Management"
             "Others")

    # Display options and prompt for selection
    PS3="Please select a module (1-22): "
    select module in "${options[@]}"; do
        if [[ -n "$module" ]]; then
            echo "Selected Module: $module"
            break
        else
            echo "Invalid option. Please try again."
        fi
    done

    # Step 2: Select Business Unit
    echo "B. Select Business Unit:"
    business_units=("Tenant"
                    "Customer"
                    "KCP"
                    "Mill"
                    "Mill/KCP"
                    "Platform Admin"
                    "Platform Management"
                    "Refinery"
                    "Supply Chain Department"
                    "Tenant Admin")

    # Display options and prompt for selection
    PS3="Please select a business unit (1-10): "
    select business_unit in "${business_units[@]}"; do
        if [[ -n "$business_unit" ]]; then
            echo "Selected Business Unit: $business_unit"
            break
        else
            echo "Invalid option. Please try again."
        fi
    done

    # Step 3: Get Use Case ID
    read -p "C. Enter Use Case ID: " use_case_id

    # Step 4: Get JIRA Issue No
    read -p "D. Enter JIRA Issue No: " jira_issue_no

    # Step 5: Get Change Summary
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
