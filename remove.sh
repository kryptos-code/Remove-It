#!/bin/bash
DATE_STAMP=`date`

# Directories path are described below
BASE_DIR="E:/Project/scripts/remove-it"
MEDIA_DIR="C:/Users/shoai/Downloads/Media"
ARCHIVE_DIR="C:/Users/shoai/Downloads/Archive"

# Change file retention using below variable
EFFECTIVE_DAYS=15

# Change file retention using below variable
REMOVAL_DAYS=5

LOG_FILE=$BASE_DIR/logs/removeIt.log

echo "################### REMOVE IT :: STARTED ###################" >> $LOG_FILE
echo "TIME STAMP: $DATE_STAMP" >>  $LOG_FILE
echo "                       " >>  $LOG_FILE

echo "###### ARCHIVES REMOVING :: STARTED ######" >> $LOG_FILE
cd $ARCHIVE_DIR

echo "Changed directory to "`pwd` >> $LOG_FILE
archive_count=`ls  | wc -l | awk '{print $1}'`

if [ $archive_count -gt 0 ]
then

    for file in ./*
    do
        echo "$file is available!" >> $LOG_FILE
        STATICS=`stat -c '%w' "$file"`
        STATICS_SECONDS=`stat -c '%W' "$file"`
        TIME_SECONDS=`date +%s`
        
        echo "Creation date: $STATICS" >> $LOG_FILE

        TIME_DIFF=$((($TIME_SECONDS-$STATICS_SECONDS)/86400))

        # echo  "Time Difference: $TIME_DIFF">> $LOG_FILE

        if [ $TIME_DIFF -gt $REMOVAL_DAYS ]
        then
            rm $file
            echo "$file is deleted!" >> $LOG_FILE
        fi
        echo "                       " >>  $LOG_FILE
    done

else
    echo "No files found in archive directory!" >> $LOG_FILE
fi
echo "###### ARCHIVES REMOVING :: ENDED ######" >> $LOG_FILE

echo "                       " >>  $LOG_FILE
echo "###### FILES ARCHIVING :: STARTED ######" >> $LOG_FILE
cd $MEDIA_DIR

echo "Changed directory to "`pwd` >> $LOG_FILE
file_count=`ls  | wc -l | awk '{print $1}'`

if [ $file_count -gt 0 ]
then

    for file in ./*
    do
        echo "$file is available!" >> $LOG_FILE
        STATICS=`stat -c '%y' "$file"`
        STATICS_SECONDS=`stat -c '%Y' "$file"`
        TIME_SECONDS=`date +%s`
        
        echo "Creation date: $STATICS" >> $LOG_FILE

        TIME_DIFF=$((($TIME_SECONDS-$STATICS_SECONDS)/86400))

        # echo  "Time Difference: $TIME_DIFF">> $LOG_FILE

        if [ $TIME_DIFF -gt $EFFECTIVE_DAYS ]
        then
            mv $file $ARCHIVE_DIR/$file
            echo "$file is archived!" >> $LOG_FILE
        fi
        echo "                       " >>  $LOG_FILE
    done

else
    echo "No files found in media directory!" >> $LOG_FILE
fi
echo "###### FILES ARCHIVING :: STARTED ######" >> $LOG_FILE
echo "                       " >>  $LOG_FILE
echo "TIME STAMP: $DATE_STAMP" >>  $LOG_FILE
echo "################### REMOVE IT :: ENDED ###################" >> $LOG_FILE

exit
EOF