# README

## users テーブル

| Column          | type    | options     |
| --------------- | ------- | ----------- |
| nickname        | string  | null: false |
| email           | string  | null: false |
| password        | string  | null: false |
| last_name       | string  | null: false |
| first_name      | string  | null: false |
| last_name_kana  | string  | null: false |
| first_name_kana | string  | null: false |
| birth_day       | date    | null: false |


### Association
- has_many :items
- has_one :shipping_addresses
- has_one :purchases

## items テーブル

| Column              | type       | options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| info                | text       | null: false                    |
| category            | string     | null: false                    |
| status              | string     | null: false                    |
| shipping_fee_status | string     | null: false                    |
| prefecture          | string     | null: false                    |
| scheduled_delivery  | string     | null: false                    |
| price               | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- has_one :shipping_addresses
- has_one :purchases

## shipping_addresses テーブル

| Column              | type       | options                        |
| ------------------- | ---------- | ------------------------------ |
| postal_code         | integer    | null: false                    |
| prefecture          | text       | null: false                    |
| city                | string     | null: false                    |
| addresses           | string     | null: false                    |
| building            | string     |                                |
| phone_number        | integer    | null: false                    |

### Association
- has_one :users
- has_one :items

## purchases テーブル
| Column              | type       | options                        |
| ------------------- | ---------- | ------------------------------ |
| user                | string     | null: false                    |
| item                | string     | null: false                    |
| purchase_day        | date       | null: false                    |

### Association
- has_one :users
- has_one :items