Las imágenes de seguridad muestran que había 2 testigos. El primer testigo vive en la última casa de "Northwestern Dr". El segundo testigo, llamado Annabel, vive en algún lugar de "Franklin Ave".

annabel miller
Vi el asesinato y reconocí al asesino de mi gimnasio cuando estaba entrenando la semana pasada, el 9 de enero.

Morty Schapiro
Escuché un disparo y luego vi a un hombre salir corriendo. Tenía una bolsa de "Get Fit Now Gym". El número de membresía en la bolsa comenzaba con "48Z". Solo los miembros dorados tienen esas bolsas. El hombre subió a un automóvil con una placa que incluía "H42W".

48Z7A	28819
48Z55	67318
	183779

67318 <-- asesino
Me contrató una mujer con mucho dinero. No sé su nombre, pero sé que mide alrededor de 5'5" (65") o 5'7" (67"). Es pelirroja y conduce un Tesla Model S. Sé que asistió al Concierto Sinfónico de SQL 3 veces en diciembre de 2017.

78881
90700
99716

Miranda Priestly <- mente maestra
Jeremy Bowers <- asesino	





--select *
--from crime_scene_report
--where city = 'SQL City'
--and type = 'murder'
--and date = '20180115'
              
--select *
--from person
--where address_street_name == 'Northwestern Dr'
--order by address_number

--select *
--from interview
--where person_id == 14887

--select *
--from interview
--where person_id == 16371

--select *
--from get_fit_now_check_in
--where check_in_date == '20180109'

--select *
--from get_fit_now_member as gm, get_fit_now_check_in as gc, person as p
--where gm.id = gc.membership_id
--and gm.person_id = p.id
--and gc.check_in_date == '20180109'
--and gc.membership_id LIKE '48Z%'

--select *
--from interview
--where person_id == 67318

--select *
--from drivers_license
--where plate_number LIKE 'H42W%'

select p.id, p.name
from drivers_license as dl, person as p, facebook_event_checkin as fb
where p.license_id = dl.id
and p.id = fb.person_id
and dl.hair_color == 'red'
and dl.car_make == 'Tesla'
and dl.gender == 'female'
and fb.event_name == 'SQL Symphony Concert'

--select *
--from facebook_event_checkin
--where event_name == 'SQL Symphony Concert'
--and person_id == 99716

--select *
--from person
--where id == 67318
