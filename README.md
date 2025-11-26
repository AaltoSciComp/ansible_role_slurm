# ansible_role_slurm

This role builds, installs and manages [Slurm](https://github.com/SchedMD/slurm) for HPC clusters.

## Requirements

This role has been tested on the following operating systems:
  - Rocky9

## Role Variables

### Slurm build settings

| Variable                            | Default value                   | Description                                                                                                           |
|-------------------------------------|---------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| `slurm_version`                     | `25.11.0`                       | Slurm version                                                                                                         |
| `slurm_build_rpm`                   | `false`                         | Build Slurm RPMs                                                                                                      |
| `slurm_src_url`                     | `"'https://download.schedmd.com/slurm/slurm-{{ slurm_version }}.tar.bz2'"`                            | Download url for Slurm source code              |
| `slurm_calculate_checksum`          | `true`                          | Calculate checksum for slurm source code                                                                              |
| `slurm_user_uid`                    | `202`                           | Slurm user UID                                                                                                        |
| `slurm_munge_user_uid`              | `203`                           | munge user UID                                                                                                        |
| `pmix_version`                      | `4.2.6`                         | PMIx version                                                                                                          |
| `slurm_build_pmix`                  | `true`                          | Build PMIx RPMs                                                                                                       |
| `pmix_calculate_checksum`           | `true`                          | Calculate checksum for pmix source code                                                                               |
| `pmix_src_url`                      | `"'https://github.com/openpmix/openpmix/releases/download/v{{ pmix_version }}/pmix-{{ pmix_version }}.tar.bz2'"` | Download url for Slurm source code   |


### Slurm repo variables

| Variable                            | Default value                   | Description                                                                                                           |
|-------------------------------------|---------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| `slurm_createrepo`                  | `true`                          | Whether this role should create and manage a RPM repository for Slurm                                                 |
| `slurm_rpm_repodir`                 | `/var/www/html/slurm_repo`      | Location for the slurm repository                                                                                     |
| `slurm_rpm_fetchdir`                | `''`                            | Directory on the local machine where PRM's should be fetched into                                                     |
| `slurm_create_mungekey`             | `false`                         | Whether this role should create and manage the munge key                                                              |
| `slurm_mungekey_path_`              | `''`                            | Location where the created munge key should be fetched into                                                           |

### Slurm installation settings

| Variable                            | Default value                   | Description                                                                                                           |
|-------------------------------------|---------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| `slurm_repo_name`                   | `slurm`                         | Name for the RPM repository                                                                                           |
| `slurm_repo_baseurl`                | `''`                            | URL for the repository. This should point to the host with `repo_host` as a role (e.g. `http://builder/slurm_repo/`). |
| `slurm_host_roles`                  | `[]`                            | List of roles that this host should play in the cluster. Possible options are `build_host`, `repo_host`, `slurmctld`, `slurmrestd`, `slurmdbd`, `compute` and `submit` |
| `slurm_log_dir`                     | `/var/log/slurm`                | Log directory for slurm                                                                                               |
| `slurm_state_save_location`         | `/var/spool/slurm`              | Location for slurm states                                                                                             |
| `slurm_tool_install`                | `false`                         | Whether [slurm_tool](https://github.com/AaltoSciComp/slurm_tool/tree/master) should be installed on submit, compute and slurmctld hosts. |
| `slurm_tool_repo`                   | `https://github.com/AaltoSciComp/slurm_tool.git` | Repo for slurm_tool.                                                                                 |
| `slurm_tool_version`                | `1.0.1`                         | Version or commit of slurm_tool.                                                                                      |

### Slurm configuration settings

| Variable                            | Default value                   | Description                                                                                                           |
|-------------------------------------|---------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| `slurmdbd_mysql_root_password`      | `'password'`                    | Password for root user in slurmdbd mysql                                                                              |
| `slurmdb_password`                  | `'password'`                    | Password for slurm user in slurmdbd mysql                                                                             |
| `slurm_innodb_buffer_pool_size`     | `'1024M'`                       | InnoDB buffer pool size                                                                                               |
| `slurm_innodb_log_file_size`        | `'64M'`                         | InnoDB log file size                                                                                                  |
| `slurm_innodb_log_wait_timeout`     | `'900'`                         | InnoDB log wait timeout                                                                                               |
| `slurmdbd_mysql_service`            |`'mariadb'`                      | Name of the mysql service                                                                                             |
| `slurm_slurm_conf_template`         |`'files/slurm.conf.j2'`          | Configuration template for slurm.conf                                                                                 |
| `slurm_slurmdbd_conf_template`      |`'files/slurmdbd.conf.j2'`       | Configuration template for slurmdbd.conf                                                                              |
| `slurm_cgroup_conf_template`        |`'files/cgroup.conf.j2'`         | Configuration template for cgroup.conf                                                                                |
| `slurm_gres_conf_template`          |`'files/gres.conf.j2'`           | Configuration template for gres.conf                                                                                  |
| `slurm_topology_conf_template`      |`'files/topology.conf.j2'`       | Configuration template for topology.conf                                                                              |
| `slurm_epilog_script`               |`'files/epilog.j2'`              | Template for epilog script. This will be placed in `/usr/bin/epilog`.                                                 |
| `slurm_prolog_scripts`              |`[files/prolog_placeholder.sh.j2]` | Templates for prolog scripts. These will be placed in `/usr/local/libexec/slurm/prolog.d/`.                         |
| `slurm_epilog_scripts`              |`[files/epilog_placeholder.sh.j2]` | Templates for epilog scripts. These will be placed in `/usr/local/libexec/slurm/epilog.d/`.                         |
| `slurm_enable_pam_slurm`            | `true`                          | Will this role enable `/etc/pam.d/slurm`                                                                              |
| `slurm_enable_pam_slurm_adopt`      | `true`                          | Should this role insert `slurm_pam_adopt_setting` into `/etc/pam.d/system-auth` to enable `pam_slurm_adopt.so`.       |
| `slurm_pam_adopt_setting`           | `'-account     sufficient    pam_slurm_adopt.so action_adopt_failure=deny action_generic_failure=deny'` | Line that will enable `pam_slurm_adopt.so.`   |
| `slurm_enable_configless_profiled`  | `true`                          | Should scripts be created in `/etc/profile.d` that enable the configless setup for users                              |
| `slurm_cluster_name`                | `cluster`                       | Name of the cluster. This cluster will be created.                                                                    |
| `slurmctld_hosts`                   | `slurm_controller`              | Comma separated list of slurmctld hosts.                                                                              |
| `slurmdbd_host`                     | `slurm_database`                | Name of the slurmdbd host.                                                                                            |

Many variables are used in the configuration templates.

## Additional variables

### Choosing slurm features to build

By default Slurm is built with these features:

```yml
slurm_rpmbuild_features:
  ucx:
  hwloc:
  pmix:
  numa:
  mysql:
  lua:
  slurmrestd:
  pam:
  jwt:
  bpf:
```

Each feature is a map between feature name - build flags given to the rpmbuild. You can give custom build
flags with this to the rpm creation. For example,

```yml
slurm_rpmbuild_features:
  ucx:        '--with ucx /path/to/my/ucx'
```

would build against UCX in a custom path. When the value is empty, default values are used.


### Adding new checksums

Checksums are listed in these variables:

```yml
slurm_checksums:
  '25.11.0': 'sha1:7a0fc39b0836e068f1a4c4a2ba7a32a4c342d909'
  '23.02.4': "sha1:5ea4dabca78cd48611caf100e052a954f659516c"
  '22.05.9': "sha1:cc853549724375cfab111529f7b7db0cc0dd1bbb"

pmix_checksums:
  '4.2.6': "sha1:c66a6c2ce73dcb3a83109ade87b2cd6ef2e4395b"
```

| Variable                            | Default value                   | Description                                                                                                           |
|-------------------------------------|---------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| `slurm_checksums`                   | dictionary given above          | Slurm version checksums as a map                                                                                      |
| `pmix_checksums`                    | dictionary given above          | PMIx version checksums as a map                                                                                       |

Dependencies
------------

- `community.mysql`

Example Playbook
----------------

To be finalized.

For now see [molecule converge playbook](./molecule/default/converge.yml).

For a start, to build RPMs only, use the following `slurm.yml` playbook

```yml
---
# Minimal RPM build-only playbook role
- name: Slurm RPM build host
  hosts: slurm_builder
  vars:
    slurm_build_rpm: true
    slurm_host_roles:
      - build_host
  roles:
    - ansible_role_slurm
```
where you list a host (compute node) or a group under [slurm_builder] inventory and run it limited with

    ansible-playbook slurm.yml  -lslurm_builder --tags build_slurm

and check `/root/rpmbuild/RPMS/x86_64` therein for later hosting with `- repo_host` or own move elsewhere.


License
-------

MIT

Author Information
------------------

- Simo Tuomisto <simo.tuomisto@aalto.fi>
- Some modifications to Slurm RPM spec are originally written by [OHPC](https://openhpc.community/).
