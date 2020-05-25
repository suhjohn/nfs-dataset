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

# transform to "1/ssh -p 22 <username>@clnodexxx.clemson.cloudlab.us"
yaml_nodes = [
    f"{PARALLEL_PER_NODE}/ssh -p 22 {username}@{node}" for node in all_client_nodes
]

yaml_data = {
    "nodes": yaml_nodes
}

# HACK assumes that lrb exists in root
settings_fp = os.path.expanduser('~/lrb/config/execution_settings.yaml')
with open(settings_fp, 'w+') as outfile:
    yaml.dump(yaml_data, outfile, default_flow_style=False)
