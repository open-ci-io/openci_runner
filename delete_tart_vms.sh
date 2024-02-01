#!/bin/bash

ids=(
)

for id in "${ids[@]}"; do
    echo "Deleting $id..."
    tart delete "$id"
done

echo "All specified IDs have been deleted."
