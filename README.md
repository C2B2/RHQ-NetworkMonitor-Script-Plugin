RHQ Linux Network Monitoring Script Plugin
==========================================

Objective
---------
Collect more detailed network statistics using the RHQ Script plugin and a shell script that parses /proc/net/netstat and the tc command.

Description
-----------

I've extended the RHQ Script Plugin to collect metric using a Shell script with multiple metrics.

By default the RHQ Script Plugin works by executing a shell script, but only collects the Availability metric, or a single metric that is the output of the script. To collect multiple metrics from the same script, you need to extend the plugin to add metric elements to rhq-plugin.xml.

I copied the the two Java classes ScriptServerComponent.java and ScriptDiscoveryComponent.java from the RHQ source. It should be possible to access the existing classes, but that requires fiddling with classloaders.

This plugin does not have auto-discovery, so you need to create the server component in RHQ manually. This can be implemented later by looking for the shell-script in a location on the filesystem in the ScriptDiscoveryComponent.

Build instructions
-------------------

Clone the Git repository:
      git clone

Build the JAR file with Maven:
      mvn clean package

Install instructions
-------------------
 
### Copy Shell Script ###

1. Logon to the machine that you want to monitor with the same user as is running the RHQ agent

2. Copy the bundled shellscript procstat.sh to /opt/rhq-scripts/

3. Give execute rights to the shellscript 
     chmod +x procstat.sh

4. (Optional) Edit procstat.sh to change the network device that you want to monitor (default = eth0)

### RHQ Plugin Installation ###

1. Log into RHQ 
     - default url: <host>:7080/
     - default credentials: rhqadmin / rhqadmin

2. Navigate to Administration -> Agent Plugins

3. Select the JAR file using Upload Plugin and Browse.

4. Click Upload to send the JAR to RHQ

5. Click Scan for Updates to have RHQ find the new plugin

6. Either restart the RHQ agent where you want to run the shell script, or use the RHQ Inventory to schedule a Plugin update operation/

### Create Linux Network Monitoring Server component ###

This plugin does not have auto-discovery, so you need to create the server component in RHQ manually. This can be implemented by by looking for the shell-script in a location on the filesystem.

1. Navigate to the Platform (Linux host) that you want to monitor in RHQ Inventory

2. Navigate to the Inventory tab and click Import -> Linux Network Monitor Script

3. Fill in the location of the shell script, everything else is optional.
     /opt/rhq-scripts/procstat.sh

4. Click Finish to create the new Server. 

5. The agent should be collecting detailed network statistics every minute, and are available below the Platform (Linux Host) -> Linux Network Monitor Scripts.

Note: if the RHQ Server complains about Resource Types not find, you might need to restart the RHQ server.
