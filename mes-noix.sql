SET sql_mode = ' ';

SELECT 
    `m`.`fr_title` `french title`,
    `m`.`original_title` `original title`,
    `m`.`rating`,
    `m`.`production_budget` `production budget`,
    `m`.`marketing_budget` `marketing budget`,
    `m`.`duration`,
    `m`.`release_date` `release date`,
    `m`.`3d`,
    `m`.`synopsis`,
    `p`.`firstname`,
    `p`.`lastname`,
    `rp`.`name` `role`,
    `c`.`name` `company's name`,
    `rc`.`name` `company's role`,
    `moc`.`country_iso2` `country`
FROM `movies` `m`
JOIN `movies_people_roles` `mpr` ON `m`.`id` = `mpr`.`movie_id`
JOIN `people` `p` ON `mpr`.`people_id` = `p`.`id`
JOIN `roles` `rp` ON `mpr`.`role_id` = `rp`.`id`
JOIN `movies_companies_roles` `mcr` ON `mcr`.`movie_id` = `m`.`id`
JOIN `companies` `c` ON `c`.`id` = `mcr`.`company_id`
JOIN `roles` `rc` ON `rc`.`id` = `mcr`.`role_id`
JOIN `movies_origin_countries` `moc` ON `moc`.`movie_id` = `m`.`id`;