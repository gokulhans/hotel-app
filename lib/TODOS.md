* Todos

- splash screen
- logo
- offline storage
- details page design
- Naturoots heading on center 

- Search implementation in front page
- search err showing no item found
- item sorted view 
- design every page simply


  if (snapshot.data?.docs.length == 0) {
            return const Center(
              child: Center(child: Text('Item not found. '),),
            );
          }