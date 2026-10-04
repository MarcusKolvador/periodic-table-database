first_arg=$1

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ $1 ]]; then
  query_return=$($PSQL "SELECT e.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius
  FROM elements e 
  JOIN properties p ON e.atomic_number = p.atomic_number 
  JOIN types t on p.type_id = t.type_id
  WHERE e.atomic_number::text = '$first_arg' OR symbol = '$first_arg' OR name = '$first_arg'")
  if [[ -z "$query_return" ]]; then
    echo "I could not find that element in the database."
  else
    IFS='|' read -r atomic_number name symbol type atomic_mass melting_point_celsius boiling_point_celsius <<< "$query_return"
    echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
  fi
else
  echo "Please provide an element as an argument."
fi