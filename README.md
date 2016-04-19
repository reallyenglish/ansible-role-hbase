Role Name
=========

Install hbase as a single node

Requirements
------------

None

Role Variables
--------------

| variable | description | default |
|----------|-------------|---------|
| hbase\_user           | user name of the service | hbase |
| hbase\_group          | group name of the service | hbase |
| hbase\_log\_dir       | log dir | /var/log/hbase |
| hbase\_db\_dir        | database dir | "{{ \_\_hbase\_db\_dir }}" |
| hbase\_zookeeper\_dir | path to zoopkeeper dir | "{{ \_\_hbase\_zookeeper\_dir }}" |
| hbase\_conf\_dir      | path to config file dir | "{{ \_\_hbase\_conf\_dir }}" |
| hbase\_service        | service name | "{{ \_\_hbase\_service }}" |
| hbase\_conf           | path to hbase\_site.xml | "{{ \_\_hbase\_conf }}" |
| hbase\_flags          | not used yet | "" |
| hbase\_site\_xml      | content of site.xml without header and <configuration> | "" |

Dependencies
------------

None

Example Playbook
----------------

    - hosts: all
      roles:
        - ansible-role-hbase
      vars:
        hbase_site_xml: |
          <property>
            <name>hbase.rootdir</name>
            <value>file://{{ hbase_db_dir }}</value>
          </property>
          <property>
            <name>hbase.zookeeper.property.dataDir</name>
            <value>/var/db/zookeeper</value>
          </property>

License
-------

BSD

Author Information
------------------

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>
