# Test cases for automatic database ownership

## Test Case 1: Single user with ALL privileges
postgresql:
  additionalDatabases:
    - name: test_db
      # Should be owned by test_user
  additionalUsers:
    - username: test_user
      password: test123
      databases: [test_db]
      privileges: ALL

Expected: test_db OWNER test_user

## Test Case 2: Multiple users, first with ALL gets ownership
postgresql:
  additionalDatabases:
    - name: shared_db
      # Should be owned by app_user (first with ALL)
  additionalUsers:
    - username: app_user
      password: app123
      databases: [shared_db]
      privileges: ALL
    - username: readonly_user
      password: read123
      databases: [shared_db]
      privileges: SELECT

Expected: shared_db OWNER app_user

## Test Case 3: Explicit owner overrides automatic
postgresql:
  additionalDatabases:
    - name: system_db
      owner: postgres  # Explicit override
  additionalUsers:
    - username: app_user
      password: app123
      databases: [system_db]
      privileges: ALL

Expected: system_db OWNER postgres

## Test Case 4: No user with ALL privileges
postgresql:
  additionalDatabases:
    - name: public_db
      # No owner set, no user with ALL
  additionalUsers:
    - username: viewer
      password: view123
      databases: [public_db]
      privileges: SELECT

Expected: public_db OWNER (not set, defaults to postgres)

## Test Case 5: Multiple databases, one user
postgresql:
  additionalDatabases:
    - name: db1
      # Should be owned by multi_user
    - name: db2
      # Should be owned by multi_user
    - name: db3
      # Should be owned by multi_user
  additionalUsers:
    - username: multi_user
      password: multi123
      databases: [db1, db2, db3]
      privileges: ALL

Expected:
  - db1 OWNER multi_user
  - db2 OWNER multi_user
  - db3 OWNER multi_user
