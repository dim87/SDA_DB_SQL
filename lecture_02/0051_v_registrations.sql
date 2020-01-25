drop view if exists v_registrations;

create or replace view v_registrations (
	id,
	registration_id,
	purchase_order_id,
	organization_id,
	status_id,
	number_plate,
	external_customer_id,
	customer_title,
	transport_group_id,
	transport_group_title,
	registered_date,
	planned_date,
	release_time,
	pallet_count,
	seal,
	phone_number,
	car_type,
	gate,
	door,
	comment,
	external_id,
	archive_status_id,
	archive_status_date
) as
	select 
		row_number() over (order by r.id, po.id)::int,
		r.id registrationId,
		po.id,

		r.organization_id,
		r.status_id,
		r.number_plate,
		po.external_customer_id,
		po.customer_title,

		tg.id,
		concat_ws(' - ', tg.external_id, tg.title),
		r.created,
		po.delivery_date,
		r.release_time,
		r.pallet_count,
		r.seal,

		r.phone_number,
		ct.name,
		r.gate,
		r.door,
		r.comment,
		po.external_id ::varchar(20),
		rsa.new_status_id,
		rsa.created
	from registrations r
		left join registration_purchase_orders rpo on r.id = rpo.registration_id
		left join purchase_orders po on rpo.purchase_order_id = po.id
		left join transport_groups tg on po.transport_group_id = tg.id
		left join car_types ct on r.car_type_id = ct.id
		left join registration_status_archive rsa on r.id = rsa.registration_id
	
union all (
	select row_number() over (order by r.id, ppo.id)::int,
		r.id registrationId,
		null,

		r.organization_id,
		r.status_id,
		r.number_plate,
		null,
		rppo.supplier,

		tg.id,
		CASE WHEN tg.id IS NOT NULL THEN concat_ws(' - ', tg.external_id, tg.title) END,
		r.created,
		null,
		r.release_time,
		r.pallet_count,
		r.seal,

		r.phone_number,
		ct.name,
		r.gate,
		r.door,
		r.comment,
		ppo.title,
		rsa.new_status_id,
		rsa.created
	from registrations r
		left join registration_predefined_purchase_orders rppo on r.id = rppo.registration_id
		left join predefined_purchase_orders ppo on rppo.predefined_purchase_order_id = ppo.id
		left join car_types ct on r.car_type_id = ct.id
		left join registration_status_archive rsa on r.id = rsa.registration_id
		left join registration_predefined_purchase_order_transport_groups rppotg on rppo.id = rppotg.registration_predefined_purchase_order_id
		left join transport_groups tg on rppotg.transport_group_id = tg.id
	);



