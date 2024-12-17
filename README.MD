# **Active Directory Lab Setup**

### **Overview**
This repository documents the setup and configuration of a virtual Active Directory lab environment designed to simulate a corporate IT infrastructure. The lab provides hands-on experience with Active Directory, networking, file sharing, email systems, and more.

---

### **Key Features**
- **Active Directory Domain**:
  - Configured with Windows Server 2019 as the Domain Controller.
  - Organizational Units (OUs) and security groups for role-based access control.
  - Automated user creation and group assignments using PowerShell scripts.
  
- **Networking**:
  - pfSense firewall for routing and security.
  - DHCP server for dynamic IP allocation.
  - DNS server for domain name resolution.

- **File Server**:
  - Departmental file shares with permissions based on security groups.

- **Internal Email System**:
  - hMailServer configured for internal email communication.
  - Supports Thunderbird for testing email workflows.

- **Automation**:
  - Automated tasks for user creation, group assignments, and resource provisioning using PowerShell.

- **Backup and Recovery**:
  - Comprehensive backup solution for AD, file shares, and other critical configurations.

---

### **Completed Tasks**
- **Active Directory Setup**: Configured AD DS, DNS, DHCP, and GPOs.
- **File Server**: Shared drives set up with appropriate permissions for departments.
- **Email System**: Internal email server installed and functional with basic clients.
- **Automation**: Automated repetitive tasks like user creation with scripts.
- **Backup Solution**: Implemented backup and recovery processes.

---

### **Planned Improvements**
- Monitoring system to track server health, network performance, and resource usage.
- Security enhancements, including advanced GPOs and auditing.
- Integration of corporate tools like ticketing systems and collaborative platforms.
- Testing hybrid cloud integration with Microsoft Azure.

---

### **Repository Structure**
```plaintext
ad-automation/
│
├── scripts/                # PowerShell scripts for automation
│   ├── ou-creation.ps1     # Script to create Organizational Units
│   ├── group-creation.ps1  # Script to create security groups
│   ├── user-creation.ps1   # Script to create users and assign them to groups
│
├── templates/              # CSV templates for automation
│   ├── users.csv           # Template for user creation
│   ├── groups.csv          # Template for group creation
│   └── ou.csv              # Template for OU creation
│
└── README.md               # Repository overview
```

---

### **Getting Started**
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/ad-automation.git
   ```
2. Use the CSV templates in the `templates/` folder to define your users, groups, and OUs.
3. Run the PowerShell scripts in the `scripts/` folder to automate the creation of your AD environment:
   - `ou-creation.ps1` to create Organizational Units.
   - `group-creation.ps1` to create security groups.
   - `user-creation.ps1` to create users and assign them to groups.

4. Verify the results in your Active Directory environment.

---

### **Contributing**
Contributions are welcome! Feel free to submit issues or pull requests to improve this repository.

---

### **License**
This project is licensed under the [MIT License](LICENSE).
