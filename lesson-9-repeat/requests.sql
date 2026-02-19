USE medical_healthcare;

SELECT *, CASE WHEN appointment_date > '2023-01-01' THEN 'low' 
WHEN appointment_date > '2022-01-01' THEN 'middle'
ELSE 'high'
END priority
FROM Appointments WHERE reason LIKE '%quickly%' 
ORDER BY appointment_date DESC LIMIT 10 OFFSET 5;

SELECT *, IF (appointment_date > '2023-01-01', 'low', 'high') AS priority
FROM Appointments WHERE reason LIKE '%quickly%';

SELECT * FROM Appointments ORDER BY appointment_date ASC, doctor_id DESC;

SELECT * FROM Appointments WHERE appointment_date > '2023-01-01';

SELECT COUNT(doctor_id) AS new_appointment_count FROM Appointments WHERE appointment_date > '2023-01-01';

SELECT MIN(appointment_date) AS min_appointment_date FROM Appointments;
SELECT MAX(appointment_date) AS max_appointment_date FROM Appointments;

SELECT doctor_id, COUNT(appointment_id) AS total_doctor_appointment 
FROM Appointments GROUP BY doctor_id ORDER BY total_doctor_appointment;

SELECT doctor_id, COUNT(appointment_id) AS total_doctor_appointment 
FROM Appointments GROUP BY doctor_id 
HAVING total_doctor_appointment > 4
ORDER BY total_doctor_appointment ASC;

SELECT first_name, 'doctor' AS status FROM Doctors
UNION ALL
SELECT first_name, 'patient' AS status FROM Patients ORDER BY status;

SELECT first_name, 'doctor' AS status FROM Doctors
UNION
SELECT first_name, 'patient' AS status FROM Patients ORDER BY status;

SELECT appointment_id, appointment_date, CONCAT(first_name, ' ', last_name) AS full_name
FROM Appointments
JOIN Doctors ON Appointments.doctor_id = Doctors.doctor_id 
ORDER BY appointment_date DESC;

SELECT ap.appointment_id, ap.appointment_date, 
CONCAT(p.first_name, ' ', p.last_name) AS patient_full_name,
p.phone AS patient_phone, p.email AS patient_email,
CONCAT(d.first_name, ' ', d.last_name) AS doctor_full_name
FROM Appointments ap
JOIN Doctors d ON ap.doctor_id = d.doctor_id 
JOIN Patients p ON ap.patient_id = p.patient_id
ORDER BY appointment_date DESC;

SELECT ap.doctor_id, CONCAT(d.first_name, ' ', d.last_name) AS full_name, 
COUNT(ap.appointment_id) AS total_doctor_appointment 
FROM Appointments ap
JOIN Doctors d ON ap.doctor_id = d.doctor_id 
GROUP BY doctor_id 
ORDER BY total_doctor_appointment;

SELECT * FROM Appointments WHERE doctor_id = MAX(doctor_id);

INSERT INTO Appointments (appointment_id) VALUES(5);
