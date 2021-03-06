// Filename: pathReplace.I
// Created by:  drose (07Feb03)
//
////////////////////////////////////////////////////////////////////
//
// PANDA 3D SOFTWARE
// Copyright (c) Carnegie Mellon University.  All rights reserved.
//
// All use of this software is subject to the terms of the revised BSD
// license.  You should have received a copy of this license along
// with this source code in a file named "LICENSE."
//
////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////
//     Function: PathReplace::clear_error
//       Access: Public
//  Description: Resets the error flag to the no-error state.
//               had_error() will return false until a new error is
//               generated.
////////////////////////////////////////////////////////////////////
INLINE void PathReplace::
clear_error() {
  _error_flag = false;
}

////////////////////////////////////////////////////////////////////
//     Function: PathReplace::had_error
//       Access: Public
//  Description: Returns true if an error was detected since the last
//               call to clear_error(), false otherwise.
////////////////////////////////////////////////////////////////////
INLINE bool PathReplace::
had_error() const {
  return _error_flag;
}

////////////////////////////////////////////////////////////////////
//     Function: PathReplace::clear
//       Access: Public
//  Description: Removes all the patterns from the specification.
////////////////////////////////////////////////////////////////////
INLINE void PathReplace::
clear() {
  clear_error();
  _entries.clear();
}

////////////////////////////////////////////////////////////////////
//     Function: PathReplace::add_pattern
//       Access: Public
//  Description: Adds the indicated original/replace pattern to the
//               specification.  If a filename is encountered whose
//               initial prefix matches the indicated orig_prefix,
//               that prefix will be replaced with replacement_prefix.
////////////////////////////////////////////////////////////////////
INLINE void PathReplace::
add_pattern(const string &orig_prefix, const string &replacement_prefix) {
  _entries.push_back(Entry(orig_prefix, replacement_prefix));
}

////////////////////////////////////////////////////////////////////
//     Function: PathReplace::get_num_patterns
//       Access: Public
//  Description: Returns the number of original/replace patterns that
//               have been added.
////////////////////////////////////////////////////////////////////
INLINE int PathReplace::
get_num_patterns() const {
  return _entries.size();
}

////////////////////////////////////////////////////////////////////
//     Function: PathReplace::get_orig_prefix
//       Access: Public
//  Description: Returns the original prefix associated with the nth
//               pattern.
////////////////////////////////////////////////////////////////////
INLINE const string &PathReplace::
get_orig_prefix(int n) const {
  nassertr(n >= 0 && n < (int)_entries.size(), _entries[0]._orig_prefix);
  return _entries[n]._orig_prefix;
}

////////////////////////////////////////////////////////////////////
//     Function: PathReplace::get_replacement_prefix
//       Access: Public
//  Description: Returns the replacement prefix associated with the nth
//               pattern.
////////////////////////////////////////////////////////////////////
INLINE const string &PathReplace::
get_replacement_prefix(int n) const {
  nassertr(n >= 0 && n < (int)_entries.size(), _entries[0]._replacement_prefix);
  return _entries[n]._replacement_prefix;
}

////////////////////////////////////////////////////////////////////
//     Function: PathReplace::is_empty
//       Access: Public
//  Description: Returns true if the PathReplace object specifies no
//               action, or false if convert_path() may do something.
////////////////////////////////////////////////////////////////////
INLINE bool PathReplace::
is_empty() const {
  return (_entries.empty() && _path.is_empty() && _path_store == PS_keep);
}

////////////////////////////////////////////////////////////////////
//     Function: PathReplace::convert_path
//       Access: Public
//  Description: Calls match_path() followed by store_path(), to
//               replace the initial prefix and then convert the file
//               for storing, as the user indicated.
////////////////////////////////////////////////////////////////////
INLINE Filename PathReplace::
convert_path(const Filename &orig_filename, const DSearchPath &additional_path) {
  Filename fullpath, outpath;
  full_convert_path(orig_filename, additional_path, fullpath, outpath);
  return outpath;
}

////////////////////////////////////////////////////////////////////
//     Function: PathReplace::Component::Constructor
//       Access: Public
//  Description: 
////////////////////////////////////////////////////////////////////
INLINE PathReplace::Component::
Component(const string &component) :
  _orig_prefix(component),
  _double_star(component == "**")
{
}

////////////////////////////////////////////////////////////////////
//     Function: PathReplace::Component::Copy Constructor
//       Access: Public
//  Description: 
////////////////////////////////////////////////////////////////////
INLINE PathReplace::Component::
Component(const PathReplace::Component &copy) :
  _orig_prefix(copy._orig_prefix),
  _double_star(copy._double_star)
{
}

////////////////////////////////////////////////////////////////////
//     Function: PathReplace::Component::Copy Assignment
//       Access: Public
//  Description: 
////////////////////////////////////////////////////////////////////
INLINE void PathReplace::Component::
operator = (const PathReplace::Component &copy) {
  _orig_prefix = copy._orig_prefix;
  _double_star = copy._double_star;
}

////////////////////////////////////////////////////////////////////
//     Function: PathReplace::Entry::Copy Constructor
//       Access: Public
//  Description: 
////////////////////////////////////////////////////////////////////
INLINE PathReplace::Entry::
Entry(const PathReplace::Entry &copy) :
  _orig_prefix(copy._orig_prefix),
  _orig_components(copy._orig_components),
  _is_local(copy._is_local),
  _replacement_prefix(copy._replacement_prefix)
{
}

////////////////////////////////////////////////////////////////////
//     Function: PathReplace::Entry::Copy Assignment
//       Access: Public
//  Description: 
////////////////////////////////////////////////////////////////////
INLINE void PathReplace::Entry::
operator = (const PathReplace::Entry &copy) {
  _orig_prefix = copy._orig_prefix;
  _orig_components = copy._orig_components;
  _is_local = copy._is_local;
  _replacement_prefix = copy._replacement_prefix;
}
