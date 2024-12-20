# README

# テーブル設計

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| admin_name         | string  | null: false |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false |

## Association

- has_many :stores


## stores テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| store_name    | string     | null: false |
| store_guide   | text       | null: false |
| store_address | string     | null: false |
| store_tel     | string     | null: false |
| user          | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- has_one :option
- has_many :reservations
- has_many :calendars


## options テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| theme_color_id  | integer    | null: false |
| only_table      | boolean    | null: false |
| time_zone_exist | boolean    | null: false |
| cancel_able     | boolean    | null: false |
| cancel_limit    | time       | null: false |
| store           | references | null: false, foreign_key: true |

## Association

- belongs_to :store


## reservations テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| rsv_date        | date       | null: false |
| rsv_n           | integer    | null: false |
| rsv_time_id     | integer    | null: false |
| explain         | string     |             |
| service_type_id | integer    | null: false |
| upper_people_n  | integer    |             |
| fee             | integer    |             |
| store           | references | null: false, foreign_key: true |
| rsv_group       | references | foreign_key: true |

## Association

- belongs_to :store
- belongs_to :rsv_group
- has_many :guests


## rsv_groups テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| store           | references | null: false, foreign_key: true |
| calendar        | references | null: false, foreign_key: true |

## Association

- belongs_to :store
- belongs_to :calendar
- has_many :reservations


## calendar テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| std_date        | date       | null: false |
| store           | references | null: false, foreign_key: true |

## Association

- belongs_to :store
- has_many :rsv_groups


## guests テーブル

| Column      | Type       | Options     |
| ----------- | ---------- | ----------- |
| name        | string     | null: false |
| mail        | string     |             |
| people_n    | integer    |             |
| tel         | string     |             |
| reservation | references | null: false, foreign_key: true |

## Association

- belongs_to :reservation
- has_one :rsv_number


## rsv_number テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| unique-number | string     | null: false, unique: true      |
| guest         | references | null: false, foreign_key: true |

## Association

- belongs_to :guest
