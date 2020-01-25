create or replace view v_returns_empties (
	return_id,
	return_date,
	return_status,
	store,
	ready_to_return,
	comment,
	article_id,
	article_title,
	quantity_to_return,
	approved,
	approve_date,
	receive_id,
	quantity_received,
	receive_status
) AS (
	select 
		r.id                                                                                             return_id,
		r.created                                                                                        return_date,
		return_statuses.title                                                                            return_status,
		o.name                                                                                           store,
		r.ready_to_return,
		r.comment,
		return_article_article.external_id                                                               article_id,
		return_article_article.title                                                                     article_title,
		ra.quantity                                                                                      quantity_to_return,
		ra.approved                                                                                      approved,
		CASE WHEN (receive_articles.quantity_received is null) THEN null ELSE receive.created END        approve_date,
		CASE WHEN (receive_articles.quantity_received is null) THEN null ELSE receive.id END             receive_id,
		receive_articles.quantity_received                                                               quantity_received,
		CASE WHEN (receive_articles.quantity_received is null) THEN null ELSE receive_statuses.title END receive_status
	from returns r
		left join return_articles ra on r.id = ra.return_id
		join organizations o on r.organization_id = o.id
		join return_statuses on r.status_id = return_statuses.id
		join receives receive on receive.return_id = r.id
		join receive_statuses on receive.status_id = receive_statuses.id
		left join receive_articles on receive_articles.return_article_id = ra.id
		left join articles return_article_article on ra.article_id = return_article_article.id
	where (return_article_article.group_id = 1)
		and r.status_id > 1
	order by return_id, ra.id
)
union all
(
	select 
		r2.id                 return_id,
		r2.created            return_date,
		rs.title              return_status,
		o2.name               store,
		r2.ready_to_return,
		r2.comment,
		a.external_id         article_id,
		a.title               article_title,
		null                  quantity_to_return,
		false                 approved,
		null                  approve_date,
		r3.id                 receive_id,
		ra2.quantity_received quantity_received,
		rs2.title             receive_status
	from returns r2
		join return_statuses rs on r2.status_id = rs.id
		join organizations o2 on r2.organization_id = o2.id
		join receives r3 on r2.id = r3.return_id
		join receive_statuses rs2 on r3.status_id = rs2.id
		join receive_articles ra2 on r3.id = ra2.receive_id
		join articles a on ra2.article_id = a.id
	where ra2.return_article_id is null
)
order by return_id;
