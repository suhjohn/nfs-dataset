import re
import subprocess
import yaml
import sys
import os

PARALLEL_PER_NODE = 8

username = subprocess.check_output("whoami").decode().split()[0]
manifest_info = subprocess.check_output(["geni-get", "manifest"]).decode()
all_nodes = set(re.findall(r'clnode[0-9]+.clemson.cloudlab.us', manifest_info))
nfs_node_hostname = {
    re.search(r'clnode[0-9]+', manifest_info).group(0)
    for node_info in re.findall(r'interface_ref.+', manifest_info)
    if "nfs" in node_info
}
assert len(nfs_node_hostname) == 1
nfs_node_hostname = nfs_node_hostname.pop()

# list of 'clnodexxx.<location>.cloudlab.us'. Only tested in clemson so far
all_client_nodes = [
    node for node in all_nodes if nfs_node_hostname not in node
]

base_dir = f"/proj/cops-PG0/workspaces/{username}"
for node in all_client_nodes:
    full_ssh_path = f"{username}@{node}"
    command = f"ssh {full_ssh_path} 'pwd'"
    p = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, shell=True)
    pwd = p.stdout.decode("utf-8").split()[0]
    if pwd != base_dir:
        is_setup = False
        for _ in range(2):
            command = f"ssh {full_ssh_path} 'pwd'"
            p = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, shell=True)
            pwd = p.stdout.decode("utf-8").split()[0]
            if pwd == base_dir:
                print(f"node {node} is properly setup!")
                is_setup = True
                break
        if not is_setup:
            print(f"node {node} base directory is not {base_dir}. pwd result: {pwd} \n"
              f"Node should be setup again.")
    else:
        print(f"node {node} is properly setup!")