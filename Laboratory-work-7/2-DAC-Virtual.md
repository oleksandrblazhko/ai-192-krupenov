### Вибіркове керування санкціонованим доступом до даних з горизонтальним обмеженням доступу

> 1. Заповніть таблицю БД ще трьома рядками.

![](img/2023-11-14-13-33-01.png)

> 2. Створіть схему даних користувача, назва якої співпадає з назвою користувача, та створіть віртуальну таблицю у цій схемі з правилами вибіркового керування доступом для користувача так, щоб він міг побачити тільки деякі з рядків таблиці з урахуванням одного значення її останнього стовпчика.

![](img/2023-11-14-14-13-27.png)

![](img/2023-11-14-14-34-18.png)

> 3. Встановіть з’єднання з СКБД від імені нового користувача
> 4. Перевірте роботу механізму вибіркового керування, виконавши операцію SELECT до віртуальної таблиці.

Представлення `krupenyov.student` показує лише ті записи, в яких `course` не більше 4, що включає 2 з 3 записів. `SELECT` таблиці `student` з нового користувача (*префікс `=>` замість `=#`*) показує:

![](img/2023-11-14-14-35-05.png)

> 5. Створіть INSERT/UPDATE/DELETE-правила обробки операцій редагування віртуальної таблиці.

Правило `INSERT` (*дописує `?` до `s_name`*):

![](img/2023-11-14-15-15-56.png)

Правило `DELETE` (*дописує `< DELETED >` до `s_name` замість видалення*):

![](img/2023-11-14-15-23-01.png)

Правило `UPDATE` (*при зміні імені, прибирає `,` та `.`*):

![](img/2023-11-14-15-33-13.png)

> 6. Перевірте роботу механізму вибіркового керування, виконавши операції INSERT, UPDATE, DELETE до віртуальної таблиці.

![](img/2023-11-14-15-16-44.png)

![](img/2023-11-14-15-23-51.png)

![](img/2023-11-14-15-37-49.png)