#!/bin/bash

# Path to the commit message file
commit_msg_file="/home/ubuntu/test-repo/.git/COMMIT_EDITMSG"

# Function to display options and prompt for input
prompt_for_input() {
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
    
    select module in "${options[@]}"; do
        if [[ -n "$module" ]]; then
            echo "Selected Module: $module"
            break
        else
            echo "Invalid option. Please try again."
        fi
    done

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

    select business_unit in "${business_units[@]}"; do
        if [[ -n "$business_unit" ]]; then
            echo "Selected Business Unit: $business_unit"
            break
        else
            echo "Invalid option. Please try again."
        fi
    done

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

    # Log the commit message for debugging
    echo "Constructed Commit Message: $commit_message"

    # Write the commit message to the commit message file
    echo "$commit_message" > "$commit_msg_file"
}

# Execute the function to start the process
prompt_for_input

# Confirm that the commit message has been correctly written
if [[ -f "$commit_msg_file" ]]; then
    echo "Commit message successfully written to $commit_msg_file."
else
    echo "Failed to write commit message."
fi
