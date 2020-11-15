def makeDate(date,dt):
    params = date.split("-")
    return dt.date( int(params[0]), int(params[1]), int(params[2]) )

def getCareteamID(cursor):
    sql = 'select * from Careteam'
    cursor.execute(sql)
    id = len(cursor.fetchall())
    return id + 1

def equalIds(medics,ids):
    medics.sort()
    ids.sort()
    for i in range(3):
        if medics[i] != ids[i]:
            return False
    return True    

def insertCareteam(medics,cursor):
    sql = 'select * from Careteam_Medics where careteam_id='
    ids = []
    rowcount = 0
    stop = False
    careteam = getCareteamID(cursor)
    res = 1
    for i in range(1,careteam):
        cursor.execute(sql + str(i))
        for row in cursor.fetchall():
            rowcount = rowcount + 1
            ids.append(row[1])
        if(rowcount==3):
            if (equalIds(medics,ids)):
               stop = True
               break
        res = res + 1
        ids = []
        rowcount = 0
    if stop==True:
        print("Workteam exists with IDs: " + ' '.join([str(elem) for elem in medics]))
    else: 
        sql = 'begin insert into Careteam(id) values (' + str(careteam) +');commit; exception when DUP_VAL_ON_INDEX then ROLLBACK; end;'
        sql2 = 'begin insert into Careteam_Medics(careteam_id,medic_id) values ((:1),(:2));commit; exception when DUP_VAL_ON_INDEX then ROLLBACK; end;'
        cursor.execute(sql)
        for medic in medics:
            cursor.execute(sql2,(careteam,medic))
        print("Workteam was added with IDs " + ' '.join([str(elem) for elem in medics]))
    print (str(res) + " " + "/ " + str(careteam)) 
    return res 
            
def insertPatient(id,name,birthdate,age,cursor):
    sql = 'begin insert into Patient(id,name,birthdate,age) values ((:1),(:2),(:3),(:4));commit; exception when DUP_VAL_ON_INDEX then ROLLBACK; end;'
    
    cursor.execute(sql,(id,name,birthdate,age))

def insertService(cod,desc,cursor):
    sql = 'begin insert into Service(cod,descr) values ((:1),(:2));commit; exception when DUP_VAL_ON_INDEX then ROLLBACK; end;'
    
    cursor.execute(sql,(cod,desc))

def insertMedic(id, name, cursor):
    sql = 'begin insert into Medic(id,name) values ((:1),(:2));commit; exception when DUP_VAL_ON_INDEX then ROLLBACK; end;'
    
    cursor.execute(sql,(id,name))

def insertSensor(id, num, t, cursor):
    sql = 'begin insert into Sensor(id,num,type) values ((:1),(:2),(:3));commit; exception when DUP_VAL_ON_INDEX then ROLLBACK; end;'
    
    cursor.execute(sql,(id,num,t))

def insertMonitor(sensorid,patientid,servicecod,ct_id,number_of_sensors,admdate,bed,bodytemp,systolic,diastolic,bpm,sato2,timestamp,cursor):
    check = "select * from Monitor where patient_id=(:1) and timestamp=to_date((:2),'YYYY-MM-DD HH24:MI:SS')"
    cursor.execute(check,(patientid,timestamp))
    count = cursor.fetchone()

    if(count == None):
        sql = "begin insert into Monitor values ((:1),(:2),(:3),(:4),(:5),to_date((:6),'YYYY-MM-DD'),(:7),(:8),(:9),(:10),(:11),(:12),to_date((:13),'YYYY-MM-DD HH24:MI:SS'));commit; exception when DUP_VAL_ON_INDEX then ROLLBACK; end;"
        
        cursor.execute(sql,(sensorid,patientid,servicecod,ct_id,number_of_sensors,admdate,bed,bodytemp,systolic,diastolic,bpm,sato2,timestamp))
    else:
        print("Already Monitored: " + str(patientid) + " " + timestamp)
        