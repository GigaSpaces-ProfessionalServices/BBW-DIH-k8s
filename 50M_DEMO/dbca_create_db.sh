#!/bin/bash

export CDB_NAME=cdb1
export PDB_NAME=pdb1
export PASS=Shmulik1!
dbca -silent -createDatabase \
 -templateName General_Purpose.dbc \
 -gdbname $CDB_NAME -sid $CDB_NAME -responseFile NO_VALUE \
 -characterSet AL32UTF8 \
 -sysPassword $PASS \
 -systemPassword $PASS \
 -createAsContainerDatabase true \
 -numberOfPDBs 1 \
 -pdbName $PDB_NAME \
 -pdbAdminPassword $PASS \
 -databaseType MULTIPURPOSE \
 -memoryMgmtType auto_sga \
 -totalMemory 8192 \
 -storageType FS \
 -datafileDestination "$ORACLE_HOME/oradata" \
 -redoLogFileSize 50 \
 -emConfiguration NONE \
 -ignorePreReqs
